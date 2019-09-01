from flask import Flask,render_template,flash,redirect,url_for,session,logging,request, jsonify
from wtforms import Form,StringField,TextAreaField,PasswordField,validators
from passlib.hash import sha256_crypt
from flask_mysqldb import MySQL
from functools import wraps
from datetime import date
from flask_ngrok import run_with_ngrok

class RegisterForm(Form):
    user_fullname = StringField("Ad Soyad",validators=[validators.DataRequired(message="Alanlar boş bırakılamaz!")])
    user_email = StringField("Mail Adresi",validators=[validators.Email(message="Geçerli mail adresi giriniz!")])
    username = StringField("Kullanıcı Adı",validators=[validators.DataRequired(message=" boş bırakılamaz!")])
    password = PasswordField("Şifre",validators=[validators.data_required(message="Alanlar boş bırakılamaz!")])
class LoginForm(Form):
    username = StringField("Kullanıcı Adı")
    password = PasswordField("Şifre")

app = Flask(__name__)
# run_with_ngrok(app)
app.secret_key = "sekretarya"
today = date.today()

app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = ""
app.config["MYSQL_DB"] = "sekretarya"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"
mysql = MySQL(app)

def login_required(f):
    @wraps(f)
    def decorated_function(*args,**kwargs):
        if "logged_in" in session:
            return f(*args,**kwargs)
        else:
            return redirect(url_for("login"))
    return decorated_function

@app.route("/",methods=['GET','POST'])
@login_required
def index():
    return render_template("index.html")
@app.route("/selectcompany",methods=['GET','POST'])
def selectcompany():
    cursor = mysql.connection.cursor()    
    query = "select * from companies"    
    result = cursor.execute(query)
    sonuc = ""
    if result > 0:
        companies = cursor.fetchall()

        for company in companies:
            sonuc += "<tr>"
            sonuc += "<td>"+str(company['id'])+"</td>"
            sonuc += "<td>"+company['company_name']+"</td>"
            sonuc += "<td>"+company['company_phone']+"</td>"
            sonuc += "<td>"+company['company_address']+"</td>"
            sonuc += "<td>"+company['customer_name']+"</td>"
            sonuc += "<td>"+company['comment']+"</td>"
            sonuc += "</tr>"
        return sonuc
@app.route("/aboutcompany",methods=['GET','POST'])
def aboutcompany():
    company_id = request.form.get('company_id')
    company_name = request.form.get('company_name')
    company_phone = request.form.get('company_phone')
    company_address = request.form.get('company_address')
    customer_name = request.form.get('customer_name')
    comment = request.form.get('comment')
    cursor = mysql.connection.cursor()
    if int(company_id) == 0:#INSERT
        query = "INSERT INTO companies (company_name,company_phone,company_address,customer_name,comment) values (%s,%s,%s,%s,%s)"
        cursor.execute(query,(company_name,company_phone,company_address,customer_name,comment))
    else:#UPDATE
        query = "UPDATE companies SET company_name = %s , company_phone = %s , company_address = %s , customer_name = %s , comment = %s WHERE id = %s;"
        cursor.execute(query,(company_name,company_phone,company_address,customer_name,comment,company_id))
    mysql.connection.commit()
    cursor.close()
    return redirect(url_for("index"))
@app.route("/deletecompany",methods=['GET','POST'])
def deletecompany():
    company_id = request.form.get('company_id')
    cursor = mysql.connection.cursor()
    query = "DELETE from companies where id = %s"
    cursor.execute(query,(company_id,))
    mysql.connection.commit()
    cursor.close()
    return redirect(url_for("index"))
@app.route("/taskdate",methods=['GET','POST'])
def taskdate(datetaskentered = True):
    selecteddate = request.form.get('selecteddate')
    if datetaskentered != True:
        selecteddate = datetaskentered
    elif not(selecteddate):
        selecteddate = today.strftime("%Y-%m-%d")
    cursor = mysql.connection.cursor()
    query = "SELECT * from secretary_tasks WHERE task_date = '{}'".format(selecteddate)
    result = cursor.execute(query)
    sonuc = ""
    if result > 0:
        tasks = cursor.fetchall()        
        for task in tasks:
            sonuc += "<ul>"
            #sonuc += "<li>"+task["task"]+"</li>"
            sonuc += "<a id='task'><span id='taskbullet' style='color:"+task["task_situation"]+";'>&#9673 </span>"+task["task"]+"</a>"
            sonuc += "</ul>"
    else:
        return "Bu tarihe ait görev mevcut değil!"
    return sonuc
@app.route("/updatetaskcolor",methods=['GET','POST'])
def updatetaskcolor():
    taskcolor = request.form.get('taskcolor')
    task = request.form.get('task')
    cursor = mysql.connection.cursor()
    query = "update secretary_tasks set task_situation = %s where task = %s"
    cursor.execute(query,(taskcolor , task))
    mysql.connection.commit()
    cursor.close()
    return redirect(url_for("index"))
@app.route("/insertdate",methods=['GET','POST'])
def insertdate():
    taskentered = request.form.get('taskentered')
    datetaskentered = request.form.get('datetaskentered')
    cursor = mysql.connection.cursor()
    query = "insert into secretary_tasks (task_date,task) values(%s,%s)"
    cursor.execute(query,(datetaskentered,taskentered))
    mysql.connection.commit()
    cursor.close()
    return taskdate(datetaskentered)
@app.route("/livesearch",methods=['GET','POST'])
def livesearch():
    searchbox = request.form.get('searchbox')
    cursor = mysql.connection.cursor()
    query = "select * from companies where company_name LIKE '%{}%'".format(searchbox)
    result = cursor.execute(query)
    sonuc = ""
    if result > 0:
        companies = cursor.fetchall()
  
        for company in companies:
            sonuc += "<tr>"
            sonuc += "<td>"+str(company['id'])+"</td>"
            sonuc += "<td>"+company['company_name']+"</td>"
            sonuc += "<td>"+company['company_phone']+"</td>"
            sonuc += "<td>"+company['company_address']+"</td>"
            sonuc += "<td>"+company['customer_name']+"</td>"
            sonuc += "<td>"+company['comment']+"</td>"
            sonuc +="</tr>"

    return sonuc

@app.route("/registeruser",methods=['GET', 'POST'])
def registeruser():
    form = RegisterForm(request.form)
    if request.method == "POST" and form.validate():
        user_fullname = form.user_fullname.data
        user_email = form.user_email.data
        username = form.username.data
        password = sha256_crypt.encrypt(form.password.data)

        cursor = mysql.connection.cursor()
        query = "INSERT INTO users (user_fullname,user_email,username,password) values(%s,%s,%s,%s)"
        cursor.execute(query,(user_fullname,user_email,username,password))
        mysql.connection.commit()
        cursor.close()
        flash("Kayıt Başarılı!","success")
        return redirect(url_for("login"))
    else:
        return render_template("registeruser.html",form = form)
@app.route("/login",methods=['GET', 'POST'])
def login():
    form = LoginForm(request.form)
    if request.method == "POST" and form.validate():
        username = form.username.data
        password_entered = form.password.data
        cursor = mysql.connection.cursor()
        query = "select * from users where username = %s"
        result = cursor.execute(query,(username,))
        if result > 0:
            data = cursor.fetchone()
            real_password = data["password"]
            if sha256_crypt.verify(password_entered,real_password):
                session["logged_in"] = True
                session["username"] = username
                return redirect(url_for("index"))
            else:
                flash("Şifre yanlış","danger")
                return redirect(url_for("login"))
        else:
            flash("Girilen kullanıcı bulunamadı","warning")
            return redirect(url_for("login"))    
        return redirect(url_for("index"))
    else:
        return render_template("login.html",form = form)
@app.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("index"))
if __name__ == "__main__":
    app.run(debug=True)
    # app.run()