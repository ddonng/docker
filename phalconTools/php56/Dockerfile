# PHP5.6 phalcon的devtools，pdo_mysql、memcached与mongo扩展
FROM php:5.6-fpm

MAINTAINER XiaodongHuang <ddonng@qq.com>

RUN apt-get update && apt-get install -y git
RUN docker-php-ext-install pdo_mysql

# phalcon extension
RUN git clone http://github.com/phalcon/cphalcon
RUN cd cphalcon/build && ./install \
    && echo extension=phalcon.so >> /usr/local/etc/php/conf.d/phalcon.ini
RUN rm -rf cphalcon

RUN mkdir /devtools
COPY ./composer.json /devtools
RUN cd /devtools \
  && curl -s http://getcomposer.org/installer | php \
  && php composer.phar install \
  && echo 'alias phalcon="/devtools/vendor/phalcon/devtools/phalcon.php"'>>~/.bashrc \
  && ln -s /devtools/vendor/phalcon/devtools/phalcon.php /usr/bin/phalcon \
  && chmod ugo+x /usr/bin/phalcon

RUN apt-get remove -y build-essential libmemcached-dev libz-dev git \
    && apt-get autoremove -y
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
WORKDIR /var/www/html
VOLUME ["/var/www/html"]
