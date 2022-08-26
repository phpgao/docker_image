FROM python:3.10.6-alpine

LABEL maintainer="endoffight@gmail.com"

ENV CRON_SIGNIN='0 0,9,15 * * *'
ENV MULTI=TRUE

WORKDIR /data

RUN apk add --no-cache git && \ 
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    git clone https://github.com/Womsxd/AutoMihoyoBBS.git && \
    cd AutoMihoyoBBS && \
    pip install -r requirements.txt

WORKDIR /data/AutoMihoyoBBS

CMD ["python3", "./docker.py" ]