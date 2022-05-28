FROM devilbox/php-fpm-8.1
LABEL maintainer="viethqb01@gmail.com"

WORKDIR /var/www/html

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl

RUN docker-php-ext-install \
    opcache \
    pdo_pgsql \
    pgsql \
    mysqli \
    pdo_mysql \
    pdo \
    sockets \
    intl \
    gd \
    xml \
    bz2 \
    pcntl \
    bcmath \
    exif

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#COPY . .
RUN cp .env.example .env
RUN composer install
