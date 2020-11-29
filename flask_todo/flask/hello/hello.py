from flask import Flask
import mysql.connector

app = Flask(__name__)

@app.route('/')
def hello():
    con = db_con()

    return 'Hello, World!'

@app.route('/<string:name>/')
def hello_with_name(name):
    con = db_con()
    cursor = con.cursor()
    cursor.execute('SELECT name FROM people')
    names =  cursor.fetchall()
    if (name,) in names:
        return 'Hello, {}!'.format(name)
    else:
        return 'Not Found'

def db_con():
    config = {
        'user':'docker', 
        'host':'db', 
        'password': 'docker', 
        'database':'hello'
    }
    con = mysql.connector.connect(**config)
    return con;

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')