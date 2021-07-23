FROM python:3.9-slim-buster

RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx \
 && rm -rf /var/lib/apt/lists/*
 
# COPY model /

RUN pip install --upgrade pip

RUN pip install --no-cache-dir -U \
    flask \
    gevent \
    gunicorn

RUN mkdir -p /opt/program
RUN mkdir -p /opt/ml

COPY model/app.py /opt/program
COPY model/model.py /opt/program
COPY model/nginx.conf /opt/program
COPY model/wsgi.py /opt/program
WORKDIR /opt/program

EXPOSE 8080

ENTRYPOINT ["python", "app.py"]
