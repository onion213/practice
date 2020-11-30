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
                'SELECT * FROM users WHERE name = %s AND enabled = TRUE;', (username,)
            )
            user = cursor.fetchone()
            close_db()
            error = None

            if user is None:
                error = 'Invalid username.'
            elif not check_password_hash(user[2], password):
                print(user[2])
                print(password)
                print(generate_password_hash(password))
                error = 'Invalid password.'
            
            if error is None:
                session.clear()
                session['uid'] = user[0]
                return redirect(url_for('home'))
            
            flash(error)

            return render_template('auth/login.html')

        else:
            uid = session.get('uid')
            if uid is not None:
                return redirect(url_for('home'))
            else:
                return render_template('auth/login.html')
        
    
    @app.route('/register', methods=['GET', 'POST'])
    def register():
        session.clear()
        if request.method == 'POST':
            username = request.form['username']
            password = request.form['password']

            db = connect_db()
            cursor = db.cursor()
            cursor.execute(
                'SELECT * FROM users WHERE name = %s AND enabled = TRUE;', (username,)
            )
            user = cursor.fetchone()
            error = None
            if user is not None:
                error = 'Username already used.'
            
            if error is None:
                print(generate_password_hash(password))
                cursor.execute(
                    'INSERT INTO users(name, password) VALUES(%s, %s);', 
                    (username, generate_password_hash(password))
                )
                db.commit()
                close_db()
                return redirect(url_for('login'))
            
            close_db()
            flash(error)
            return render_template('auth/register.html')
        else:
            return render_template('auth/register.html')

    @app.route('/home')
    def home():
        uid = session.get('uid')
        if uid is None:
            return redirect(url_for('login'))
        db = connect_db()
        cursor = db.cursor()
        cursor.execute(
            'SELECT * FROM todos WHERE user_id = %s AND done = FALSE;', (uid,)
        )
        todos = cursor.fetchall()
        return render_template('main/home.html', todos=todos)

    @app.route('/logout')
    def logout():
        session.clear()
        return redirect(url_for('login'))
    
    return app

if __name__=='__main__':
    app = create_app()
    app.run(debug=True, host='0.0.0.0')