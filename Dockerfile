# https://runnable.com/docker/python/dockerize-your-flask-application
# FROM ubuntu:16.04
FROM python:3.8-slim-buster

RUN apt-get update -y && apt-get install -y python-pip python-dev

COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

# https://pythonspeed.com/articles/activate-virtualenv-dockerfile/
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN pip install -r requirements.txt

# copies the CONTENTS of the host's src directory in container's app directory
COPY ./src /app

# https://docs.docker.com/compose/gettingstarted/
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
EXPOSE 5000

# ENTRYPOINT [ "python" ]
ENTRYPOINT [ "flask" ]

# CMD [ "app.py" ]
CMD [ "run" ]