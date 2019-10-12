FROM szainmehdi/composer:php-7.4

RUN mkdir /usr/local/bin/.composer

RUN composer global require laravel/installer

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENV PATH "/tmp/vendor/bin:${PATH}"

ENTRYPOINT ["/bin/sh", "/docker-entrypoint.sh"]

CMD ["laravel"]