FROM python:3.7-slim-buster

COPY model /

RUN pip install --upgrade pip

RUN pip install --no-cache-dir -U \
    flask \
    gevent \
    gunicorn

RUN mkdir -p /opt/program
RUN mkdir -p /opt/ml

COPY app.py /opt/program
COPY model.py /opt/program
COPY nginx.conf /opt/program
COPY wsgi.py /opt/program
WORKDIR /opt/program

EXPOSE 8080

ENTRYPOINT ["python", "app.py"]
