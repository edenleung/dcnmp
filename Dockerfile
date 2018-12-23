ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm
RUN apt update

ARG PHP_SWOOLE=false

RUN if [ ${PHP_SWOOLE} != false ]; then \
    curl -O https://github.com/swoole/swoole-src/archive/v${PHP_SWOOLE}.tar.gz -L \
    && tar -zxvf v${PHP_SWOOLE}.tar.gz \
    && mv swoole-src* swoole-src \
    && cd swoole-src \
    && phpize \
    && ./configure \
    && make clean && make && make install \
    && echo "extension=swoole.so" >> /usr/local/etc/php/php.ini \
    && php -m | grep swoole \
;fi