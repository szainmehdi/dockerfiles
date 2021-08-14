# PHP 7.4 (fpm): Development Image

Based on my [`szainmehdi/php:7.4` docker image](https://cloud.docker.com/repository/docker/szainmehdi/php),
this development version adds:

- CLI Tools
    - Bash
    - Composer
- PHP Extensions
    - xdebug
    - ast

This image uses a development-ready `php.ini` file.

### Usage
Dockerfile
```dockerfile
FROM szainmehdi/php:7.4-dev
```

Docker Compose
```yaml
php:
  image: szainmehdi/php:7.4-dev
  working_dir: /var/www
  environment:
    - XDEBUG_MODE=debug
    - XDEBUG_CLIENT_PORT=9003
    - XDEBUG_IDE_KEY=PHPSTORM
    - XDEBUG_CLIENT_HOST=host.docker.internal
```

### Customization
Copy additional `.ini` files to the `$PHP_INI_DIR/conf.d/` directory in your custom dockerfile.

```dockerfile
FROM szainmehdi/php:7.4-dev

COPY /path/to/custom.ini $PHP_INI_DIR/conf.d/
```
