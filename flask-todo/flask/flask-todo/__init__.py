from flask import Flask, render_template, g, request, redirect, url_for

def create_app():
    app = Flask(__name__)

    @app.route('/login', methods=['GET', 'POST'])
    def login():
        if request.method == 'GET':
            try:
                g.user
                return redirect(url_for('/home'))
            except AttributeError:
                return render_template('auth/login.html')
        return "a"
    
    @app.route('/register')
    def register():
        return render_template('auth/register.html')

    return app

if __name__=='__main__':
    app = create_app()
    app.run(debug=True, host='0.0.0.0')