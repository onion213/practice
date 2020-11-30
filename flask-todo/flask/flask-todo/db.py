import mysql.connector
from flask import g

def connect_db():
    if 'db' not in g:
        g.db = mysql.connector.connect(
            host='db',
            user='docker', 
            password='docker',
            database='todo'
        )
    return g.db

def close_db():
    db = g.pop('db', None)
    if db is not None:
        db.close()