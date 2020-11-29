FROM python:3.8
WORKDIR /todo
RUN python -m venv venv
RUN . /todo/venv/bin/activate && pip install --upgrade pip && pip install Flask \
    mysql-connector-python
