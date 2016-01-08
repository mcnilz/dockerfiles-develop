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
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

ENV	NODE_ENV production
RUN	git clone https://github.com/c9/core.git /cloud9
WORKDIR	/cloud9
RUN	scripts/install-sdk.sh
RUN	sed -i -e 's_127.0.0.1_0.0.0.0_g' /cloud9/configs/standalone.js 

RUN	curl -sSL https://get.docker.com/ | sh \
	&& apt-get install -y python-pip python-dev \
	&& pip install docker-compose \
	&& curl -L https://github.com/docker/machine/releases/download/v0.5.3/docker-machine_linux-amd64 >/usr/local/bin/docker-machine \
	&& chmod +x /usr/local/bin/docker-machine \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

RUN	mkdir /workspace
VOLUME	/workspace

EXPOSE	80
EXPOSE	3000

CMD	node /cloud9/server.js --listen 0.0.0.0 --port 80 -w /workspace
