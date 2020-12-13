"""
Flask-MySQL
-----------

Very basic support for MySQL.
Configs you can set:
    - MYSQL_HOST
    - MYSQL_USERNAME
    - MYSQL_PASSWORD
    - MYSQL_DATABASE
"""

from setuptools import setup

setup(
    name='Flask-MySQL-Onion',
    version='1.0',
    url='http://example.com/flask-mysql-onion/',
    license='BSD',
    author='onion',
    author_email='onion@example.com',
    description='Very basic support for MySQL in Flask Applications',
    long_description=__doc__,
    py_modules=['flask_mysql'],
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