FROM nginx:1.17.4-alpine

MAINTAINER Zain Mehdi

RUN apk add --no-cache openssl \
 	&& rm -rf /var/www/* /etc/nginx/conf.d/* \
 	&& adduser -u 82 -D -S -G www-data www-data

COPY scripts /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-nginx-*

# Copy Nginx Config
COPY resources /etc/nginx/

RUN nginx -t

# Add Healthcheck
HEALTHCHECK CMD ["docker-nginx-healthcheck"]

# Add Entrypoint
ENTRYPOINT ["docker-nginx-entrypoint"]
