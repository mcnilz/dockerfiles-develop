FROM	node:4.2

MAINTAINER Martin Schnabel <mcnilz@gmail.com>

RUN	apt-get update \
	&& apt-get install -y \
		build-essential \
		g++ \
		curl \
		libssl-dev \
		apache2-utils \
		git \
		libxml2-dev \
		sshfs \
		sudo \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

ENV	NODE_ENV production
RUN	git clone https://github.com/c9/core.git /cloud9
WORKDIR	/cloud9
RUN	scripts/install-sdk.sh
RUN	sed -i -e 's_127.0.0.1_0.0.0.0_g' /cloud9/configs/standalone.js 

RUN	curl -sSL https://get.docker.com/ | sh \
	&& curl -L https://github.com/docker/compose/releases/download/1.6.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose \
	&& curl -L https://github.com/docker/machine/releases/download/v0.6.0/docker-machine-`uname -s`-`uname -m` > /usr/local/bin/docker-machine \
	&& chmod +x /usr/local/bin/docker-machine /usr/local/bin/docker-compose \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN	mkdir /workspace
VOLUME	/workspace

EXPOSE	80
EXPOSE	3000

CMD	node /cloud9/server.js --listen 0.0.0.0 --port 80 -w /workspace
