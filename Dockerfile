FROM php:5.6-fpm

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN docker-php-source extract \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo pdo_mysql  \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-source delete

RUN pecl install xdebug-2.5.0 \
    &&  rm -rf /tmp/pear \
    && docker-php-ext-enable xdebug

RUN pecl install -o -f redis-3.1.6 \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis

RUN pecl install mongodb-1.4.2 \
    &&  rm -rf /tmp/pear \
    && docker-php-ext-enable mongodb       

CMD ["php-fpm"]
