FROM php:8.4-cli

USER root

RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    git \
    curl \
    libonig-dev \
    libxml2-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    supervisor \
    default-mysql-client \
    && docker-php-ext-configure gd --with-jpeg --with-freetype \
    && docker-php-ext-install pdo_mysql mbstring zip xml bcmath pcntl exif gd opcache \
    && printf "\\n" | pecl install -o -f redis \
    && docker-php-ext-enable redis \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "memory_limit=512M" > "$PHP_INI_DIR/conf.d/zz-memory-limit.ini" \
 && echo "realpath_cache_size=4096k" >> "$PHP_INI_DIR/conf.d/zz-memory-limit.ini" \
 && echo "realpath_cache_ttl=600"     >> "$PHP_INI_DIR/conf.d/zz-memory-limit.ini"

# Run the application as www-data for security
USER www-data

WORKDIR /app
