FROM php:7.4.0RC1-fpm-alpine

RUN docker-php-ext-install pdo_mysql bcmath

RUN apk add --no-cache --update --virtual buildDeps autoconf \
 && apk --no-cache add pcre-dev ${PHPIZE_DEPS} \
 && pecl install -o -f redis \
 && docker-php-ext-enable redis \
 &&  rm -rf /tmp/pear \
 && apk del buildDeps pcre-dev ${PHPIZE_DEPS}
