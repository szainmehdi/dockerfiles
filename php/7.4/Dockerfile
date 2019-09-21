FROM php:7.4.0RC1-fpm-alpine

RUN docker-php-ext-install pdo_mysql bcmath

RUN apk --no-cache add pcre-dev ${PHPIZE_DEPS} \
 	&& pecl install xdebug-2.8.0beta2 \
    && docker-php-ext-enable xdebug \
    && apk del pcre-dev ${PHPIZE_DEPS}
