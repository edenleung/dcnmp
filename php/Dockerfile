ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm

RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' > /etc/timezone
    
COPY ./sources.list /etc/apt/sources.list.tmp
RUN mv /etc/apt/sources.list.tmp /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libmcrypt-dev \
		libpng-dev \
        unixodbc-dev \
        gcc g++ make autoconf libc-dev pkg-config libcurl3-dev libwebp-dev libxpm-dev git zip unzip

RUN docker-php-ext-install bcmath pcntl pdo_mysql zip curl mcrypt

#Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && composer self-update --clean-backups \
    && composer config -g repo.packagist composer https://packagist.laravel-china.org

#GD
RUN docker-php-ext-configure gd --with-gd --with-webp-dir --with-jpeg-dir \
    --with-png-dir --with-zlib-dir --with-xpm-dir --with-freetype-dir \
    --enable-gd-native-ttf

RUN docker-php-ext-install gd

#Swoole
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

# REDIS
ARG PHP_REDIS=false
RUN if [ ${PHP_REDIS} != false ]; then \
    curl -O http://pecl.php.net/get/redis-${PHP_REDIS}.tgz -L \
    && pecl install redis-${PHP_REDIS}.tgz \
    && docker-php-ext-enable redis \
;fi

# PDO_SQLSRV
# ARG PHP_SQLSRV=false
# RUN if [ ${PHP_SQLSRV} != false ]; then \
#     curl -O http://pecl.php.net/get/pdo_sqlsrv-${PHP_SQLSRV}.tgz -L \
#     && pecl install pdo_sqlsrv-${PHP_SQLSRV}.tgz \
#     && docker-php-ext-enable pdo_sqlsrv \
# ;fi

WORKDIR /var/www/html
