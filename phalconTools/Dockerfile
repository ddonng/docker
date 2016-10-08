FROM php:7.0-fpm

MAINTAINER XiaodongHuang <ddonng@qq.com>

ENV extDir /usr/local/lib/php/extensions/no-debug-non-zts-20151012
COPY ./phalcon.so $extDir
RUN mkdir /devtools
WORKDIR /devtools
COPY ./composer.json /devtools
COPY ./conf/php.ini /usr/local/etc/php/
RUN apt-get update && apt-get install -y git

RUN curl -s http://getcomposer.org/installer | php
RUN php composer.phar install
RUN echo 'alias phalcon="/devtools/vendor/phalcon/devtools/phalcon.php"'>>~/.bashrc
RUN ln -s /devtools/vendor/phalcon/devtools/phalcon.php /usr/bin/phalcon
RUN chmod ugo+x /usr/bin/phalcon

VOLUME ["/var/www/html"]
