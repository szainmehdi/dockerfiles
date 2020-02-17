# Start from our customized PHP production image.
FROM szainmehdi/php:7.4

LABEL AUTHOR="Zain Mehdi"

# Add bash
RUN apk --no-cache add bash

# Install extensions
RUN	set -x \
	&& apk --no-cache add pcre-dev ${PHPIZE_DEPS} \
	&& pecl install \
		 xdebug-2.9.1 \
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
