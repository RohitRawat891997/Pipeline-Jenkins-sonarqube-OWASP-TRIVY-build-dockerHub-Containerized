# Use official PHP with Apache
FROM php:8.2-apache

# Install system dependencies & PHP extensions
RUN apt-get update && apt-get install -y \
    git curl zip unzip libonig-dev libzip-dev libpng-dev libxml2-dev \
    nodejs npm \
    && docker-php-ext-install pdo_mysql mbstring zip exif pcntl bcmath gd \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Remove default Apache sites
RUN rm -rf /etc/apache2/sites-available/*

# Copy custom Apache config
COPY laravel.conf /etc/apache2/sites-available/laravel.conf
RUN a2ensite laravel.conf
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy project files
COPY . .

# Install PHP dependencies
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-progress

# Set correct permissions for Laravel
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Install Node dependencies and build assets
RUN npm install
RUN npm run build

# Expose Apache port
EXPOSE 80

# Start Apache
CMD ["apache2ctl", "-D", "FOREGROUND"]

