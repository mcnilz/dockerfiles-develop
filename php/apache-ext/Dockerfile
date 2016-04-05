FROM	php:5.6-apache

MAINTAINER Martin Schnabel <mcnilz@gmail.com>

ENV	WEB_ROOT		/var/www/html
ENV	MONGO_VERSION		1.6.13
ENV	XHPROF_VERSION		0.9.4
ENV	MEMCACHE_VERSION	3.0.8
ENV	MEMCACHED_VERSION	2.2.0

RUN	\
	   sed -i "s|/var/www/html|\$\{WEB_ROOT\}|" /etc/apache2/apache2.conf \
	&& sed -i "s|/var/www|\$\{WEB_ROOT\}|"      /etc/apache2/apache2.conf

RUN	\
	   apt-get update \
	&& apt-get install -y \
		locales \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libghc-postgresql-libpq-dev \
		libmcrypt-dev \
		libcurl4-openssl-dev \
		libpng12-dev \
		libxslt1-dev \
		libxml2-dev \
		libicu-dev \
		libtidy-dev \
		zlib1g-dev \
		libmemcached-dev \
		socat \
		curl \
		graphicsmagick \
		msmtp \
	&& rm -r /var/lib/apt/lists/*

RUN	a2enmod rewrite headers expires

RUN	\
	   curl https://pecl.php.net/get/mongo-${MONGO_VERSION}.tgz | tar -xpz -C /usr/src/php/ext \
	&& mv /usr/src/php/ext/mongo-${MONGO_VERSION} /usr/src/php/ext/mongo \
	&& curl https://pecl.php.net/get/xhprof-${XHPROF_VERSION}.tgz | tar -xpz -C /tmp xhprof-${XHPROF_VERSION}/extension \
	&& mv /tmp/xhprof-${XHPROF_VERSION}/extension /usr/src/php/ext/xhprof \
	&& curl https://pecl.php.net/get/memcache-${MEMCACHE_VERSION}.tgz | tar -xpz -C /usr/src/php/ext \
	&& mv /usr/src/php/ext/memcache-${MEMCACHE_VERSION} /usr/src/php/ext/memcache \
	&& curl https://pecl.php.net/get/memcached-${MEMCACHED_VERSION}.tgz | tar -xpz -C /usr/src/php/ext \
	&& mv /usr/src/php/ext/memcached-${MEMCACHED_VERSION} /usr/src/php/ext/memcached

RUN	\
	   echo "de_DE.UTF-8 UTF-8" >> /etc/locale.gen \
	&& echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& echo "en_GB.UTF-8 UTF-8" >> /etc/locale.gen \
	&& echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen \
	&& echo "it_IT.UTF-8 UTF-8" >> /etc/locale.gen \
	&& echo "nl_NL.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen \
	&& /usr/sbin/update-locale LANG=en_US.UTF-8

RUN	\
	   docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-configure pgsql -with-pgsql=/usr/include/postgresql/ \
	&& docker-php-ext-configure xhprof --with-php-config=/usr/local/bin/php-config

RUN	docker-php-ext-install \
		xhprof \
		mongo \
		memcache \
		memcached \
		tidy \
		iconv \
		sockets \
		curl \
		zip \
		mbstring \
		intl \
		xmlrpc \
		xsl \
		soap \
		ctype \
		json \
		mcrypt \
		gd \
		mysql \
		pdo_mysql \
		pgsql \
		pdo_pgsql \
	&& find /usr/src/php/ext -type d -name 'build' -print | xargs /bin/rm -rf \
	&& find /usr/src/php/ext -type d -name 'autom4te.cache' -print | xargs /bin/rm -rf

COPY	sendmail.ini		/usr/local/etc/php/conf.d/
COPY	apache2-foreground	/usr/local/bin/
