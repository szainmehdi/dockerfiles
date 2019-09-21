FROM szainmehdi/php:7.4

RUN apk --no-cache add bash

RUN	set -x \
	&& apk --no-cache add pcre-dev ${PHPIZE_DEPS} \
 		&& pecl install \
 		 	xdebug-2.8.0beta2 \
 		 	ast \
    	&& docker-php-ext-enable \
    	   xdebug \
    	   ast \
    	&& apk del pcre-dev ${PHPIZE_DEPS};

# Copy over our custom xdebug INI configuration which will coexist with the automatically generated
# $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini created by the "docker-php-ext-enable xdebug" command above.
COPY ./resources/xdebug.ini $PHP_INI_DIR/conf.d

RUN set -x \
# composer
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
