FROM php:5.6-fpm
MAINTAINER Xiaodong Huang <ddonng@qq.com>

# Install wkhtmltopdf
RUN apt-get update && apt-get install -y libxrender1 libfontconfig1 libxext6
ADD wkhtmltox-0.12.3_linux-generic-amd64.tar.xz /
COPY simsun.ttc /usr/share/fonts
RUN ln -s /wkhtmltox/bin/wkhtmltopdf /usr/bin/wkhtmltopdf \
    && ln -s /wkhtmltox/bin/wkhtmltoimage /usr/bin/wkhtmltoimage \
    && chmod +x /usr/bin/wkhtmltopdf \
    && chmod +x /usr/bin/wkhtmltoimage


EXPOSE 9000
VOLUME ["/var/www/html"]
