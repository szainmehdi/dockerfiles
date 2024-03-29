# Start from our customized PHP production image.
FROM szainmehdi/php:8.0

LABEL AUTHOR="Zain Mehdi"

ENV COMPOSER_VERSION 2.1.12
ENV EXT_XDEBUG_VERSION 3.1.1

########################################################################
# Install Composer
########################################################################
RUN echo "[Build] Installing composer..." \
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
	&& apk del .build-deps

# Install composer
RUN set -x \
	&& curl -sS https://getcomposer.org/installer \
		| php -- \
			--install-dir=/usr/local/bin \
			--filename=composer \
			--version=$COMPOSER_VERSION

COPY ./resources/composer.ini $PHP_INI_DIR/conf.d/

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp/.composer

########################################################################
# Install XDebug Extensions
########################################################################
RUN echo "[Build] Installing Xdebug ${EXT_XDEBUG_VERSION}..." \
	&& docker-php-source extract > /dev/null \
    # ext-xdebug
    && mkdir -p /usr/src/php/ext/xdebug \
    && curl -fsSL https://xdebug.org/files/xdebug-${EXT_XDEBUG_VERSION}.tgz | tar xvz -C /usr/src/php/ext/xdebug --strip 1 \
    && docker-php-ext-install xdebug  > /dev/null  \
    ## cleanup
    && docker-php-source delete > /dev/null

# Copy over our custom xdebug INI configuration which will coexist with the automatically generated
# $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini created by the "docker-php-ext-enable xdebug" command above.
COPY ./resources/xdebug.ini $PHP_INI_DIR/conf.d/
COPY ./resources/opcache.ini $PHP_INI_DIR/conf.d/

# Use the development php.ini
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
