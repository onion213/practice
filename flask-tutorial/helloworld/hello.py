from flask import Flask, url_for, request
from markupsafe import escape

app = Flask(__name__)

@app.route('/')
def index():
	return 'Index Page.'

@app.route('/hello/')
def hello():
    return 'Hello, world!'

@app.route('/login')
def show_login_form():
	return 'login form'

@app.route('/login', methods=['post'])
def do_login():
	return 'logged in'

@app.route('/login2', methods=['get', 'post'])
def login():
	if request.method == 'post':
		return do_login()
	else:
		return show_login_form()

@app.route('/user/<string:username>')
def show_user_profile(username):
	return 'Name: %s' % escape(username)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
