# Start from our customized PHP production image.
FROM szainmehdi/php:7.4

LABEL AUTHOR="Zain Mehdi"

# Add bash
RUN apk --no-cache add bash

# Install extensions
RUN	set -x \
	&& apk --no-cache add pcre-dev ${PHPIZE_DEPS} \
	&& pecl install \
		 xdebug-2.9.4 \
		 ast \
	&& docker-php-ext-enable \
		 xdebug \
		 ast \
	&& apk del pcre-dev ${PHPIZE_DEPS};

# Copy over our custom xdebug INI configuration which will coexist with the automatically generated
# $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini created by the "docker-php-ext-enable xdebug" command above.
COPY ./resources/xdebug.ini $PHP_INI_DIR/conf.d/
COPY ./resources/opcache.ini $PHP_INI_DIR/conf.d/

# Use the development php.ini
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

# Install composer
RUN set -x \
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
	&& apk add --no-cache --virtual .composer-rundeps git subversion openssh-client mercurial tini bash patch make zip unzip coreutils \
	&& apk add --no-cache --virtual .build-deps zlib-dev libzip-dev \
	&& docker-php-ext-configure zip \
	&& docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) zip \
	&& runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
		| tr ',' '\n' \
		| sort -u \
		| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
		)" \
	&& apk add --no-cache --virtual .composer-phpext-rundeps $runDeps \
	&& apk del .build-deps \
	&& printf "# composer php cli ini settings\n\
	date.timezone=UTC\n\
	memory_limit=-1\n\
	opcache.enable_cli=1\n\
	" > $PHP_INI_DIR/php-cli.ini \
	&& composer global require hirak/prestissimo

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp