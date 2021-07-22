FROM 763104351884.dkr.ecr.us-west-2.amazonaws.com/tensorflow-training:2.3.0-cpu-py37-ubuntu18.04-v1.0

COPY model /

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
