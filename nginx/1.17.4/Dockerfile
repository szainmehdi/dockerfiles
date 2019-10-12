FROM nginx:1.17.4-alpine

MAINTAINER Zain Mehdi

RUN apk add --no-cache openssl \
	&& openssl dhparam -out "/etc/nginx/dhparam.pem" 2048
	
RUN rm -rf /var/www/* /etc/nginx/conf.d/* /usr/local/etc/php-fpm.d/* \
 	&& adduser -u 82 -D -S -G www-data www-data

COPY scripts /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-nginx-*

# Copy Nginx Config
COPY resources /etc/nginx/

RUN nginx -t

# Add Healthcheck
HEALTHCHECK CMD ["docker-nginx-healthcheck"]

CMD ["nginx", "-g", "daemon off;"]
