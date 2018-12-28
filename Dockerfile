ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm

ARG PHP_SWOOLE=false
ARG PHP_XDEBUG=false
ARG PHP_REDIS=false

COPY ./sources.list /etc/apt/sources.list.tmp
RUN mv /etc/apt/sources.list.tmp /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libmcrypt-dev \
		libpng-dev

RUN if [ ${PHP_SWOOLE} != false ]; then \
    curl -O http://pecl.php.net/get/swoole-${PHP_SWOOLE}.tgz -L \
    && pecl install swoole-${PHP_SWOOLE}.tgz \
    && docker-php-ext-enable swoole \
;fi

RUN if [ ${PHP_XDEBUG} != false ]; then \
    curl -O http://pecl.php.net/get/xdebug-${PHP_XDEBUG}.tgz -L \
    && pecl install xdebug-${PHP_XDEBUG}.tgz \
    && docker-php-ext-enable xdebug \
;fi

# GD
RUN docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd

# MYSQL
RUN docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-ext-install mysqli

RUN docker-php-ext-install pcntl

# REDIS
RUN if [ ${PHP_REDIS} != false ]; then \
    curl -O http://pecl.php.net/get/redis-${PHP_REDIS}.tgz -L \
    && pecl install redis-${PHP_REDIS}.tgz \
    && docker-php-ext-enable redis \
;fi