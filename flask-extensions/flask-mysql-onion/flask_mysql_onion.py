import mysql.connector
from flask import current_app, _app_ctx_stack


class MySQL(object):
    def __init__(self, app=None):
        self.app = app
        if app is not None:
            self.init_app(app)

    def init_app(self, app):
        app.config.setdefault('MYSQL_HOST', 'localhost')
        app.config.setdefault('MYSQL_USERNAME', 'root')
        app.config.setdefault('MYSQL_PASSWORD', 'root')
        app.config.setdefault('MYSQL_DATABASE', 'onion-app')
        app.teardown_appcontext(self.teardown)

    def connect(self):
        return mysql.connector.connect(
            host=current_app.config['MYSQL_HOST'],
            user=current_app.config['MYSQL_USERNAME'], 
            password=current_app.config['MYSQL_PASSWORD'],
            database=current_app.config['MYSQL_DATABASE']
        )

    def teardown(self, exception):
        ctx = _app_ctx_stack.top
        if hasattr(ctx, 'sqlite3_db'):
            ctx.sqlite3_db.close()

    @property
    def connection(self):
        ctx = _app_ctx_stack.top
        if ctx is not None:
            if not hasattr(ctx, 'mysql_db'):
                ctx.mysql_db = self.connect()
            return ctx.mysql_db
