# Start with PHP 7.4 Alpine Image
FROM php:7.4-fpm-alpine

# Install Common Utilities
RUN apk add --no-cache --update \
		bash

# Install PHP Extensions
RUN apk update && apk add --no-cache --virtual buildDeps \
        # see https://github.com/docker-library/php/issues/880
        oniguruma-dev \
		# needed for xdebug
		${PHPIZE_DEPS} \
		# needed for predis
		autoconf pcre-dev \
	# Separate out the libraries we need to preserve (and not remove)
	&& apk add --no-cache \
        # needed for pgsql
        postgresql-dev \
        # needed for gd
        libpng-dev libjpeg-turbo-dev \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    # Installing common dependencies
    && docker-php-ext-install \
		mbstring \
		pdo_mysql \
		pdo_pgsql \
		bcmath \
		opcache \
		gd \
	&& pecl install -o -f \
		redis \
		xdebug-2.9.1 \
		ast \
	&& docker-php-ext-enable \
		redis \
		xdebug \
		ast \
	&& rm -rf /tmp/pear \
	&& apk del buildDeps pcre-dev ${PHPIZE_DEPS}

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

# Use the production php.ini
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Copy PHP-FPM config, scripts, and validate syntax.
COPY resources/fpm/conf	/usr/local/etc/php-fpm.d/

# Copy over our custom xdebug INI configuration which will coexist with the automatically generated
# $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini created by the "docker-php-ext-enable xdebug" command above.
COPY resources/php.ini/xdebug.ini $PHP_INI_DIR/conf.d/
COPY resources/php.ini/disable-opcache.ini $PHP_INI_DIR/conf.d/

# Handle file uploads.
COPY resources/php.ini/uploads.ini $PHP_INI_DIR/conf.d/

# For opcache and xdebug, we'll start the image with the extensions disabled, and then enable it in the entrypoint.
RUN mv $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini.disabled \
	&& mv $PHP_INI_DIR/conf.d/xdebug.ini $PHP_INI_DIR/conf.d/xdebug.ini.disabled;

COPY scripts /usr/local/bin/

# Chmod scripts, validate Syntax
RUN chmod +x /usr/local/bin/docker-fpm-* && php-fpm -t

HEALTHCHECK CMD ["docker-fpm-healthcheck"]

ENTRYPOINT [ "docker-fpm-entrypoint" ]

CMD [ "php-fpm", "--nodaemonize" ]