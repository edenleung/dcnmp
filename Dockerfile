ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm

COPY ./sources.list /etc/apt/sources.list.tmp
RUN mv /etc/apt/sources.list.tmp /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libmcrypt-dev \
		libpng-dev \
        unixodbc-dev \
        gcc g++ make autoconf libc-dev pkg-config

RUN docker-php-ext-install bcmath pcntl pdo_mysql zip

# Swoole
ARG PHP_SWOOLE=false
RUN if [ ${PHP_SWOOLE} != false ]; then \
    curl -O http://pecl.php.net/get/swoole-${PHP_SWOOLE}.tgz -L \
    && pecl install swoole-${PHP_SWOOLE}.tgz \
    && docker-php-ext-enable swoole \
;fi

# XDEBUG
ARG PHP_XDEBUG=false
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

# REDIS
ARG PHP_REDIS=false
RUN if [ ${PHP_REDIS} != false ]; then \
    curl -O http://pecl.php.net/get/redis-${PHP_REDIS}.tgz -L \
    && pecl install redis-${PHP_REDIS}.tgz \
    && docker-php-ext-enable redis \
;fi

# PDO_SQLSRV
ARG PHP_SQLSRV=false
RUN if [ ${PHP_SQLSRV} != false ]; then \
    curl -O http://pecl.php.net/get/pdo_sqlsrv-${PHP_SQLSRV}.tgz -L \
    && pecl install pdo_sqlsrv-${PHP_SQLSRV}.tgz \
    && docker-php-ext-enable pdo_sqlsrv \
;fi
