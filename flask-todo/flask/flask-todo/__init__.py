from flask import Flask, render_template

def create_app():
    app = Flask(__name__)

    @app.route('/login')
    def login():
        return  render_template('auth/login.html', menu=[{'text': 'Register', 'func': 'register'}])
    
    @app.route('/register')
    def register():
        return render_template('auth/register.html', menu=[{'text': 'Login', 'func': 'login'}])

    return app

if __name__=='__main__':
    app = create_app()
    app.run(debug=True, host='0.0.0.0')