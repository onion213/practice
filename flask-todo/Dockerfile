FROM python:3.8
WORKDIR /todo
RUN python -m venv venv
RUN . /todo/venv/bin/activate && pip install --upgrade pip && pip install Flask \
    mysql-connector-python
COPY ./flask-extensions /flask-extensions
RUN . /todo/venv/bin/activate && pip install /flask-extensions/flask-mysql-onion