FROM php:5.6-cli
MAINTAINER Xiaodong Huang <ddonng@qq.com>

RUN apt-get update && apt-get install -y git
# install pdo_mysql extension
RUN docker-php-ext-install pdo_mysql
# install phpredis extension
ENV PHPREDIS_VERSION 2.2.8

RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
    && docker-php-ext-install redis

# install mongo extension
RUN apt-get -y install libssl-dev pkg-config && pecl install mongo \
    && echo "extension=mongo.so" > /usr/local/etc/php/conf.d/mongo.ini

# swoole extension，use 1.8.7
RUN pecl install swoole-1.8.7 && echo extension=swoole.so >> /usr/local/etc/php/conf.d/swoole.ini

# phalcon extension
RUN git clone http://github.com/phalcon/cphalcon
RUN cd cphalcon/build && ./install \
    && echo extension=phalcon.so >> /usr/local/etc/php/conf.d/phalcon.ini
RUN rm -rf cphalcon

# Install wkhtmltopdf
RUN apt-get update && apt-get install -y libxrender1 libfontconfig1 libxext6
ADD wkhtmltox-0.12.3_linux-generic-amd64.tar.xz /
COPY simsun.ttc /usr/share/fonts
RUN ln -s /wkhtmltox/bin/wkhtmltopdf /usr/bin/wkhtmltopdf \
    && ln -s /wkhtmltox/bin/wkhtmltoimage /usr/bin/wkhtmltoimage \
    && chmod +x /usr/bin/wkhtmltopdf \
    && chmod +x /usr/bin/wkhtmltoimage

# Install unoconv
RUN apt-get install -y unoconv
COPY ./convert.sh /
RUN chmod +x /convert.sh && apt-get install sudo && echo "www-data ALL=NOPASSWD: /convert.sh" >> /etc/sudoers


# clean
RUN apt-get remove -y build-essential libmemcached-dev libz-dev git \
    && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
