# 用作web服务
# php5.6

FROM php:5.6-fpm
MAINTAINER XiaodongHuang <ddonng@qq.com>

EXPOSE 9000

RUN apt-get update && apt-get install -y git
# install pdo_mysql extension
RUN docker-php-ext-install pdo_mysql

# memcached extensions
RUN apt-get update \
  && apt-get install -y libmemcached11 libmemcachedutil2 build-essential libmemcached-dev libz-dev \
  && pecl install memcached \
  && echo extension=memcached.so >> /usr/local/etc/php/conf.d/memcached.ini

# install phpredis extension

RUN pecl install -o -f redis-2.2.8 \
    && rm -rf /tmp/pear \
    && echo "extension=redis.so" >> /usr/local/etc/php/conf.d/redis.ini

# install mongo extension
RUN apt-get -y install libssl-dev pkg-config && pecl install mongo \
    && echo "extension=mongo.so" > /usr/local/etc/php/conf.d/mongo.ini

# swoole extension，use 1.8.7
RUN pecl install swoole-1.8.7 && echo extension=swoole.so >> /usr/local/etc/php/conf.d/swoole.ini

RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN pecl install memcache && echo extension=memcache.so >> /usr/local/etc/php/conf.d/memcache.ini

# phalcon extension
RUN git clone http://github.com/phalcon/cphalcon
RUN cd cphalcon/build && ./install \
    && echo extension=phalcon.so >> /usr/local/etc/php/conf.d/phalcon.ini
RUN rm -rf cphalcon

# clean
RUN apt-get remove -y build-essential libmemcached-dev libz-dev git \
    && apt-get autoremove -y

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/var/www/html"]
