FROM devilbox/php-fpm-8.1:latest
LABEL maintainer="viethqb01@gmail.com"

WORKDIR /var/www/html

RUN docker-php-ext-install pdo pdo_mysql

## Install Composer.
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
#    && ln -s $(composer config --global home) /root/composer
#ENV PATH=$PATH:/root/composer/vendor/bin COMPOSER_ALLOW_SUPERUSER=1

# Install PHP DI
COPY . .
RUN cp .env.example .env
RUN composer install --no-dev
