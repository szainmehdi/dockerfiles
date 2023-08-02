# Start with PHP 8.1 Alpine Image
FROM php:8.1-fpm-alpine

# Update Package Repositories
RUN apk update

########################################################################
# Prepare common build dependencies
########################################################################
RUN echo "[Build] Installing common build dependencies..." \
	&& apk add --no-cache --virtual buildDeps \
		# Generic dependency
		oniguruma-dev \
		${PHPIZE_DEPS} \
		autoconf \
		pcre-dev > /dev/null

########################################################################
# Install Common Extensions for Laravel
########################################################################
RUN echo "[Build] Installing common extensions..." \
	&& apk add --no-cache \
		# Dependency of GD
		libpng-dev \
		# Dependency of GD
		libjpeg-turbo-dev \
		> /dev/null \
	&& docker-php-ext-install \
	 	pdo_mysql \
		bcmath \
		opcache \
		pcntl \
		gd \
		> /dev/null

########################################################################
# Install Postgres Extension
########################################################################
RUN echo "[Build] Installing PostgreSQL extension..." \
	&& apk add --no-cache \
		postgresql-dev \
		> /dev/null \
	&& docker-php-ext-install \
		pdo_pgsql \
		> /dev/null

ENV EXT_APCU_VERSION=5.1.22
ENV EXT_REDIS_VERSION=5.3.7
ENV EXT_IGBINARY_VERSION=3.2.14

RUN echo "[Build] Installing PHP Redis extension..." \
	&& docker-php-source extract > /dev/null \
    # ext-igbinary
    && mkdir -p /usr/src/php/ext/igbinary \
    &&  curl -fsSL https://github.com/igbinary/igbinary/archive/$EXT_IGBINARY_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/igbinary --strip 1 \
    && docker-php-ext-install igbinary  > /dev/null  \
    # ext-redis
    && mkdir -p /usr/src/php/ext/redis \
    && curl -fsSL https://github.com/phpredis/phpredis/archive/$EXT_REDIS_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && docker-php-ext-configure redis --enable-redis-igbinary  > /dev/null  \
    && docker-php-ext-install redis  > /dev/null  \
    # ext-apcu
    && mkdir -p /usr/src/php/ext/apcu \
    && curl -fsSL https://github.com/krakjoe/apcu/archive/v$EXT_APCU_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/apcu --strip 1 \
    && docker-php-ext-install apcu > /dev/null  \
    ## cleanup
    && docker-php-source delete > /dev/null

########################################################################
# Cleanup
########################################################################
RUN echo "[Build] Cleaning up..." \
	&& apk del buildDeps \
		> /dev/null

########################################################################
# Set Up PHP Environment
########################################################################
RUN echo "[Build] Finishing image preparation..."

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Copy PHP-FPM config, scripts, and validate syntax.
COPY resources/fpm/conf	/usr/local/etc/php-fpm.d/

# Handle file uploads.
COPY resources/php.ini/uploads.ini $PHP_INI_DIR/conf.d/

# Validate Syntax
RUN php-fpm -t

CMD [ "php-fpm", "--nodaemonize" ]
