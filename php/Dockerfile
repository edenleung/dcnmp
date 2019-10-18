ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm-alpine

#阿里云源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk add --no-cache autoconf g++ libtool make curl-dev libxml2-dev linux-headers libzip-dev

RUN docker-php-ext-install bcmath pcntl pdo_mysql mysqli curl zip

#Composer
RUN set -x; \
    wget https://mirrors.aliyun.com/composer/composer.phar; \
    chmod u+x composer.phar; \
    mv composer.phar /usr/local/bin/composer; \
    composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

#GD
 RUN apk add --no-cache freetype-dev libjpeg-turbo-dev libpng-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install ${MC} gd

#Swoole
ARG PHP_SWOOLE=false
RUN if [ ${PHP_SWOOLE} != false ]; then \
    curl -O http://pecl.php.net/get/swoole-${PHP_SWOOLE}.tgz -L \
    && (tar -zxvf swoole-${PHP_SWOOLE}.tgz && cd swoole-${PHP_SWOOLE} && phpize && ./configure --enable-openssl && make && make install) \
    && docker-php-ext-enable swoole \
;fi

#XDEBUG
ARG PHP_XDEBUG=false
RUN if [ ${PHP_XDEBUG} != false ]; then \
    pecl install xdebug \
    && docker-php-ext-enable xdebug \
;fi

#REDIS
ARG PHP_REDIS=false
RUN if [ ${PHP_REDIS} != false ]; then \
    pecl install redis \
    && docker-php-ext-enable redis \
;fi

#PDO_SQLSRV
ARG PHP_SQLSRV=false
RUN if [ ${PHP_SQLSRV} != false ]; then \
    pecl install pdo_sqlsrv \
    && docker-php-ext-enable pdo_sqlsrv \
;fi

# MEMCACHED
ARG PHP_MEMCACHED=false
RUN if [ ${PHP_MEMCACHED} != false ]; then \
    apk add --no-cache libmemcached-dev zlib-dev \
    && pecl install memcached \
    && docker-php-ext-enable memcached \
;fi

WORKDIR /var/www/html
