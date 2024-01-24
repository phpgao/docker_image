FROM php:8-fpm-alpine

# Install PHP extensions
RUN apk update && \
    apk add libpq-dev && \
    docker-php-ext-install pdo_mysql pdo_pgsql
