# Base PHP FPM
FROM php:8.3-fpm

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    unzip \
    curl \
    libicu-dev \
    libpng-dev \
    libjpeg-dev \
    libxml2-dev \
    libc6-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    vim \
    nano \
    zlib1g-dev \
    libonig-dev \
    nodejs \
    npm \
    procps \
    sudo \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Configura e instala GD separadamente
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# Instala extensões PHP uma por uma
RUN docker-php-ext-install intl
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install zip
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install exif
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install sockets
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install ctype
RUN docker-php-ext-install xml

# Instala Composer globalmente
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Define diretório de trabalho
WORKDIR /var/www

# Copia arquivos da aplicação
COPY . .

# Permissões de diretórios do Laravel
RUN mkdir -p storage bootstrap/cache \
    && chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# Comando para iniciar o PHP-FPM
CMD ["php-fpm"]
