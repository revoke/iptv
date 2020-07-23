FROM php:7.3-apache
LABEL maintainer="radim.mericka@gmail.com"
LABEL version="1.1"
LABEL description="testovaci ukol pro sledovani.tv"

COPY . /web
COPY ./.docker/vhost.conf /etc/apache2/sites-available/000-default.conf

WORKDIR ./

RUN apt-get update
RUN apt-get upgrade -y
RUN docker-php-ext-install pdo pdo_mysql mysqli
RUN a2enmod rewrite

#COPY ./composer.* /web/
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
#RUN cd /web && composer install --no-dev --prefer-dist --optimize-autoloader && composer clear-cache