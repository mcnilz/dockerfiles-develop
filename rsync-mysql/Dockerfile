FROM	mysql:5.6

MAINTAINER Martin Schnabel <mcnilz@gmail.com>

RUN	apt-get update \
	&& apt-get install -y rsync \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
