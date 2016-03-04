FROM alpine

RUN apk --update add \
	curl \
	msmtp \
	php-apache2 \
	php-cli \
	php-json \
	php-phar \
	php-openssl \
	php-pdo_mysql \
	php-gd \
	php-intl \
	php-mcrypt \
	php-iconv \
	php-zip \
	php-zlib \
	php-curl \
	php-xml \
	php-openssl \
	&& rm -f /var/cache/apk/* \
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
	&& mkdir /app \
	&& chown -R apache:apache /app \
	&& sed -i 's#^DocumentRoot ".*#DocumentRoot "/app"#g'       /etc/apache2/httpd.conf \
	&& sed -i 's#AllowOverride none#AllowOverride All#'         /etc/apache2/httpd.conf \
	&& sed -i 's#^ErrorLog .*#ErrorLog /dev/stderr#'            /etc/apache2/httpd.conf \
	&& sed -i 's#^CustomLog .*#CustomLog /dev/stdout combined#' /etc/apache2/httpd.conf

ADD	php-custom.ini		/etc/php/conf.d/
ADD	run.sh			/run.sh

EXPOSE 80

VOLUME /app
WORKDIR /app

CMD ["/run.sh"]
