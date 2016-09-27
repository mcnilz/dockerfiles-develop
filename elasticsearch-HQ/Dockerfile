FROM nginx:alpine

ADD https://github.com/royrusso/elasticsearch-HQ/archive/master.tar.gz /app/

RUN cd /app/ && tar xzvf master.tar.gz

COPY nginx.conf /etc/nginx/nginx.conf
