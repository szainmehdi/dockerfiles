# Start with PHP 7.4 Alpine Image
FROM php:7.4.8-fpm-alpine

# Install Common Utilities
RUN apk add --no-cache --update \
		bash

# Install PHP Extensions
RUN apk update && apk add --no-cache --virtual buildDeps \
        # see https://github.com/docker-library/php/issues/880
        oniguruma-dev \
		# needed for xdebug\redis
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
		pcntl \
		gd \
	&& pecl install -o -f \
		redis \
	&& docker-php-ext-enable \
		redis \
	&& rm -rf /tmp/pear \
	&& apk del buildDeps pcre-dev ${PHPIZE_DEPS}


# Use the production php.ini
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Copy PHP-FPM config, scripts, and validate syntax.
COPY resources/fpm/conf	/usr/local/etc/php-fpm.d/

# Handle file uploads.
COPY resources/php.ini/uploads.ini $PHP_INI_DIR/conf.d/

COPY scripts /usr/local/bin/

# Chmod scripts, validate Syntax
RUN chmod +x /usr/local/bin/docker-fpm-* && php-fpm -t

HEALTHCHECK CMD ["docker-fpm-healthcheck"]

CMD [ "php-fpm", "--nodaemonize" ]