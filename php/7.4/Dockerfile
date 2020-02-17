# Start with PHP 7.4 Alpine Image
FROM php:7.4-fpm-alpine

# Install packages needed inside base image.
RUN apk add --no-cache \
#    # -----  Needed for Image----------------
	fcgi tini \
#    # -----  Needed for PHP -----------------
    curl

# Install Extensions
RUN docker-php-ext-install \
	pdo_mysql \
	bcmath \
	opcache

# Install predis extension
RUN set -x \
	&& apk add --no-cache --update --virtual buildDeps autoconf \
	&& apk --no-cache add pcre-dev ${PHPIZE_DEPS} \
	&& pecl install -o -f redis \
	&& docker-php-ext-enable redis \
	&& rm -rf /tmp/pear \
	&& apk del buildDeps pcre-dev ${PHPIZE_DEPS}

# Use the production php.ini
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Copy PHP-FPM config, scripts, and validate syntax.
COPY resources/fpm/conf	/usr/local/etc/php-fpm.d/
COPY scripts /usr/local/bin/

# Chmod scripts, validate Syntax
RUN  chmod +x /usr/local/bin/docker-fpm-* && php-fpm -t

HEALTHCHECK CMD ["docker-fpm-healthcheck"]
