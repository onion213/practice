from flask import Flask, render_template, g, request, redirect, url_for, session, flash
from werkzeug.security import check_password_hash, generate_password_hash
from db import connect_db, close_db


def create_app():
    app = Flask(__name__)
    app.secret_key = 'app secret key'

    @app.route('/login', methods=['GET', 'POST'])
    def login():
        if request.method == 'POST':
            username = request.form['username']
            password = request.form['password']
            db = connect_db()
            cursor = db.cursor()
            cursor.execute(
                'SELECT * FROM users WHERE name = %s', (username,)
            )
            user = cursor.fetchone()
            error = None

            if user is None:
                error = 'Invalid username.'
            elif check_password_hash(user['password'], password):
                error = 'Invalid password.'
            
            if error is None:
                session.clear()
                session['uid'] = user['id']
                return redirect(url_for('home'))
            
            flash(error)

            return render_template('auth/login.html')

        else:
            uid = session.get('uid')
            if uid is not None:
                return redirect(url_for('home'))
            else:
                return render_template('auth/login.html')
        
    
    @app.route('/register')
    def register():
        return render_template('auth/register.html')

    @app.route('/home')
    def home():
        uid = session.get('uid')
        if uid is None:
            return redirect(url_for('login'))
        db = connect_db()
        cursor = db.cursor
        todos = cursor.execute(
            'SELECT * FROM todos WHERE user_id = %s', (uid,)
        ).fetchall()
        return render_template('main/home.html', todos=todos)

    return app

if __name__=='__main__':
    app = create_app()
    app.run(debug=True, host='0.0.0.0')