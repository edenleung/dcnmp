ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm

RUN apt-get update && apt-get install -y \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libmcrypt-dev \
		libpng-dev

ARG PHP_SWOOLE=false

RUN if [ ${PHP_SWOOLE} != false ]; then \
    curl -O https://github.com/swoole/swoole-src/archive/v${PHP_SWOOLE}.tar.gz -L \
    && tar -zxvf v${PHP_SWOOLE}.tar.gz \
    && mv swoole-src* swoole-src \
    && cd swoole-src \
    && phpize \
    && ./configure \
    && make clean && make && make install \
    && docker-php-ext-enable swoole \
    && rm -rf swoole-src \
;fi

ARG PHP_XDEBUG=false
RUN if [ ${PHP_XDEBUG} != false ]; then \
    curl -O https://github.com/xdebug/xdebug/archive/${PHP_XDEBUG}.tar.gz -L \
    && tar -zxvf ${PHP_XDEBUG}.tar.gz \
    && mv xdebug* xdebug \
    && cd xdebug \
    && phpize \
    && ./configure \
    && make clean && make && make install \
    && docker-php-ext-enable xdebug \
    && rm -rf xdebug \
;fi

# GD
RUN docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd
RUN docker-php-ext-enable gd

# MYSQL
RUN docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo
RUN docker-php-ext-enable pdo_mysql
RUN docker-php-ext-enable mysqli
RUN docker-php-ext-enable pdo