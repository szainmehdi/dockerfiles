# PHP 8.0 (fpm)

Based on the [official `php:8.0-fpm-alpine` docker image](https://hub.docker.com/_/php), this adds:
- PHP Extensions
    - pdo_mysql
    - bcmath
    - opcache
    - predis

This image uses a production-ready `php.ini` file.

### Usage
Dockerfile
```dockerfile
FROM szainmehdi/php:8.0
```

Docker Compose
```yaml
php:
  image: szainmehdi/php:8.0
  working_dir: /var/www
```

### Customization
Copy additional `.ini` files to the `$PHP_INI_DIR/conf.d/` directory in your custom dockerfile.

```dockerfile
FROM szainmehdi/php:8.0

COPY /path/to/custom.ini $PHP_INI_DIR/conf.d/
```
