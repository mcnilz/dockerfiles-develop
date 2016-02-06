#	run cloud9 as non-root, build image with
#	docker build --build-arg USER_ID=${UID} --build-arg USER_NAME=${USER} -t c9-user-${USER} .

FROM	mcnilz/c9

MAINTAINER Martin Schnabel <mcnilz@gmail.com>

ARG	USER_ID=1000
ARG	USER_NAME=john
RUN	useradd -m ${USER_NAME} -u ${USER_ID} -g sudo
RUN	echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER	${USER_ID}
RUN	sudo chown ${USER_NAME} /workspace
RUN	sudo chown -R ${USER_NAME} /cloud9
RUN	sudo mv /root/.c9 /home/${USER_NAME} \
	&& sudo mv /root/.npm /home/${USER_NAME} \
	&& sudo mv /root/.node-gyp /home/${USER_NAME} \
	&& sudo chown -R ${USER_NAME} /home/${USER_NAME} \
	&& cd /home/${USER_NAME}/.c9/bin \
	&& ln -sf /home/${USER_NAME}/.c9/local/bin/tmux \
	&& ln -sf /home/${USER_NAME}/.c9/lib/sqlite3/sqlite3
ENV	TERMINFO_DIRS /home/${USER_NAME}/.c9/local/share/terminfo

CMD	node /cloud9/server.js --listen 0.0.0.0 --port 8080 -w /workspace
EXPOSE	8080
