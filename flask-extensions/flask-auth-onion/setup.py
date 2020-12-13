"""
Flask-Auth-Onion
-----------

Register, login, and deactivate accounts in Flask Applications
"""

from setuptools import setup

setup(
    name='Flask-Auth-Onion',
    version='1.0',
    url='http://example.com/flask-auth-onion/',
    license='BSD',
    author='onion',
    author_email='onion@example.com',
    description='Register, login, and deactivate accounts in Flask Applications',
    long_description=__doc__,
    py_modules=['flask_auth_onion'],
    zip_safe=False,
    include_package_data=True,
    platforms='any',
    install_requires=[
        'Flask',
        'flask_mysql_onion'
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