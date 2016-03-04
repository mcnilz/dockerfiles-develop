FROM alpine

RUN 	apk update \
	&& apk upgrade \
	&& apk --update add \
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
	php-ctype \
	php-openssl \
	&& rm -f /var/cache/apk/* \
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
	&& mkdir /app \
	&& chown -R apache:apache /app \
	&& sed -i 's#^DocumentRoot ".*#DocumentRoot "/app"#g'                                         /etc/apache2/httpd.conf \
	&& sed -i 's#^ErrorLog .*#ErrorLog /dev/stderr#'                                              /etc/apache2/httpd.conf \
	&& sed -i 's#\s*CustomLog .*#CustomLog /dev/stdout combined#'                                 /etc/apache2/httpd.conf \
	&& echo '<Directory "/app">'                                                               >> /etc/apache2/httpd.conf \
	&& echo '  AllowOverride All'                                                              >> /etc/apache2/httpd.conf \
	&& echo '  Options FollowSymLinks'                                                         >> /etc/apache2/httpd.conf \
	&& echo '  Require all granted'                                                            >> /etc/apache2/httpd.conf \
	&& echo '</Directory>'                                                                     >> /etc/apache2/httpd.conf \
	&& sed -i 's|^#LoadModule rewrite_module.*|LoadModule rewrite_module modules/mod_rewrite.so|' /etc/apache2/httpd.conf \
	&& sed -i 's|^#LoadModule expires_module.*|LoadModule expires_module modules/mod_expires.so|' /etc/apache2/httpd.conf

ADD	php-custom.ini		/etc/php/conf.d/
ADD	run.sh			/run.sh

EXPOSE 80

VOLUME /app
WORKDIR /app

CMD ["/run.sh"]
