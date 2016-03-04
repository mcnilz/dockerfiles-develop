#!/bin/sh
set -e

if [ ! -z "$WWW_DATA_UID" ]; then
	echo "apache uid => ${WWW_DATA_UID}"
	if [ ! -z "$WWW_DATA_GID" ]; then
		echo "www-data gid => ${WWW_DATA_GID}"
		sed -i "s#^apache:.*#apache:x:${WWW_DATA_GID}:#" /etc/group
		sed -i "s#^apache:.*#apache:x:${WWW_DATA_UID}:${WWW_DATA_GID}:apache:/var/www:/sbin/nologin#" /etc/passwd
	else
		sed -i "s#^apache:.*#apache:x:${WWW_DATA_UID}:81:apache:/var/www:/sbin/nologin#" /etc/passwd
	fi
	chown -R apache:apache /var/run/apache2
fi

httpd -D FOREGROUND
