FROM python:3.8
WORKDIR /todo
COPY ./flask-extensions /flask-extensions
RUN python -m venv venv && . /todo/venv/bin/activate && pip install --upgrade pip && pip install \
    Flask \
    mysql-connector-python \
    /flask-extensions/flask-mysql-onion