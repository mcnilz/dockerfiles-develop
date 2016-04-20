docker run \
	--rm \
	--link mysql \
	-ti \
	--name mysql-autocreate \
	--volume /var/run/docker.sock:/var/run/docker.sock:ro \
	mysql-autocreate
