"""
Flask-MySQL
-----------

Very basic support for MySQL.
Required configs in app.config:
    - MYSQL_HOST
    - MYSQL_USERNAME
    - MYSQL_PASSWORD
    - MYSQL_DATABASE
"""

from setuptools import setup

setup(
    name='Flask-MySQL',
    version='1.0',
    url='http://example.com/flask-mysql/',
    license='BSD',
    author='onion213',
    author_email='onion213@example.com',
    description='Very basic support for MySQL',
    long_description=__doc__,
    py_modules=['flask_mysql'],
    # if you would be using a package instead use packages instead
    # of py_modules:
    # packages=['flask_sqlite3'],
    zip_safe=False,
    include_package_data=True,
    platforms='any',
    install_requires=[
        'Flask',
        'mysql-connector-python'
    ],
    classifiers=[
        'Environment :: Web Environment',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: BSD License',
        'Operating System :: OS Independent',
        'Programming Language :: Python',
        'Topic :: Internet :: WWW/HTTP :: Dynamic Content',
        'Topic :: Software Development :: Libraries :: Python Modules'
    ]
)