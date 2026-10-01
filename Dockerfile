FROM php:8.5-cli

USER root

RUN cp "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
 && printf '%s\n' 'expose_php=Off' > "$PHP_INI_DIR/conf.d/zz-base.ini" \
 && apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    git \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    supervisor \
    default-mysql-client \
 && docker-php-ext-configure gd --with-jpeg --with-freetype \
 && docker-php-ext-install pdo_mysql zip bcmath pcntl exif gd \
 && printf "\\n" | pecl install -o -f redis \
 && docker-php-ext-enable redis \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "memory_limit=512M" > "$PHP_INI_DIR/conf.d/zz-memory-limit.ini" \
 && echo "realpath_cache_size=4096k" >> "$PHP_INI_DIR/conf.d/zz-memory-limit.ini" \
 && echo "realpath_cache_ttl=600"     >> "$PHP_INI_DIR/conf.d/zz-memory-limit.ini" \
 && mkdir -p /config/psysh && chown -R www-data:www-data /config/psysh

# Run the application as www-data for security
USER www-data

WORKDIR /app
