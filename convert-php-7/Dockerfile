FROM php:7-cli
MAINTAINER Xiaodong Huang <ddonng@qq.com>

# aliyun source
RUN echo 'deb http://mirrors.aliyun.com/debian/ jessie main non-free contrib\n \
deb http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib \n \
deb-src http://mirrors.aliyun.com/debian/ jessie main non-free contrib \n \
deb-src http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib'  > /etc/apt/sources.list

RUN apt-get update && apt-get install -y git
# install pdo_mysql extension
RUN docker-php-ext-install pdo_mysql

# memcached extensions
RUN apt-get install -y libmemcached11 libmemcachedutil2 build-essential libmemcached-dev libz-dev
RUN git clone -b php7 https://github.com/php-memcached-dev/php-memcached.git
RUN cd php-memcached && phpize && ./configure && make && make install \
    && echo "extension=memcached.so" >> /usr/local/etc/php/conf.d/memcached.ini

# install phpredis extension
RUN pecl install -o -f redis-3.0.0 \
    && rm -rf /tmp/pear \
    && echo "extension=redis.so" >> /usr/local/etc/php/conf.d/redis.ini

# install mongo extension
RUN apt-get install -y pkg-config libssl-dev
RUN pecl install mongodb-1.1.8 && echo "extension=mongodb.so" >> /usr/local/etc/php/conf.d/mongodb.ini

# phalcon extension
RUN apt-get install -y libpcre3-dev openssl libssl-dev
RUN git clone --depth=1 http://github.com/phalcon/cphalcon
RUN cd cphalcon/build && ./install \
    && echo extension=phalcon.so >> /usr/local/etc/php/conf.d/phalcon.ini
RUN rm -rf cphalcon

RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Install wkhtmltopdf
RUN apt-get install -y libxrender1 libfontconfig1 libxext6
ADD wkhtmltox-0.12.3_linux-generic-amd64.tar.xz /
COPY simsun.ttc /usr/share/fonts
RUN ln -s /wkhtmltox/bin/wkhtmltopdf /usr/bin/wkhtmltopdf \
    && ln -s /wkhtmltox/bin/wkhtmltoimage /usr/bin/wkhtmltoimage
RUN chmod +x /usr/bin/wkhtmltopdf \
    && chmod +x /usr/bin/wkhtmltoimage

# Install unoconv
RUN apt-get install -y unoconv
COPY ./convert.sh /
RUN chmod +x /convert.sh && apt-get install sudo && echo "www-data ALL=NOPASSWD: /convert.sh" >> /etc/sudoers \
    && ln -s /convert.sh /usr/bin/convert

# sockets extension
RUN docker-php-ext-install sockets
# swoole extension
RUN pecl install swoole-1.8.12 && echo extension=swoole.so >> /usr/local/etc/php/conf.d/swoole.ini


# clean
RUN apt-get remove -y build-essential libmemcached-dev libz-dev git \
    && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN echo date.timezone = PRC >> /usr/local/etc/php/php.ini
