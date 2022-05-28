FROM devilbox/php-fpm-8.0:latest
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
    curl \

# Configure & Install Extension
RUN docker-php-ext-configure \
    opcache --enable-opcache

RUN docker-php-ext-install \
    opcache \
    pdo_pgsql \
    pgsql \
    pdo \
    gd \
    xml \
    intl \
    sockets \
    bz2 \
    pcntl \
    bcmath \
    exif \
    zip

# Install Composer.
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && ln -s $(composer config --global home) /root/composer \

#COPY . .
#RUN composer install
