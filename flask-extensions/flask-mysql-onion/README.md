# Flask-MySQL-Onion

## You can use MySQL client in Flask applications very easily.

### Install

Not added to PyPI.
To use this module, clone to local repository and install.

```
pip install /path/to/folder/flask_mysql_onion
```

### Example Usage

```python
from flask import Flask
from flask_mysql_onion import MySQL

app = Flask(__name__)
app.config['MYSQL_USERNAME'] = 'root'
app.config['MYSQL_PASSWORD'] = 'root'
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_DATABASE'] = 'sys'
db = MySQL(app)

EXAMPLE_SQL = 'select * from sys.user_summary'


# using the connection property
@app.route('/')
def connect_db():
    conn = db.connection
    cur = conn.cursor()
    cur.execute(EXAMPLE_SQL)
    output = cur.fetchall()
    return str(output)

if __name__ == '__main__':
    app.run(debug=True)
```