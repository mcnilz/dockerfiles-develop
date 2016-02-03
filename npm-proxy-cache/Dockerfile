FROM node:4.2

MAINTAINER Martin Schnabel <mcnilz@gmail.com>

RUN npm install -g npm-proxy-cache && npm cache clean

VOLUME /data

EXPOSE 8080

CMD ["npm-proxy-cache", "-h", "0.0.0.0", "-s", "/data", "-t", "2592000"]
