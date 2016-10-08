FROM php:5.6-cli

RUN apt-get update
RUN apt-get install -y wget && wget http://pear.php.net/go-pear.phar && php go-pear.phar
RUN pear channel-discover pear.phpdoc.org
RUN pear install phpdoc/phpDocumentor

RUN apt-get install -y php5-intl
#RUN echo "deb http://security.ubuntu.com/ubuntu lucid-security main" >> /etc/apt/sources.list
#RUN echo "deb http://cz.archive.ubuntu.com/ubuntu lucid main" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y graphviz

WORKDIR /home/code/
VOLUME ["/home/code/"]
