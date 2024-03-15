# Use the official PHP image as the base image
   FROM php:7.4-fpm

   # Set the working directory in the container
   WORKDIR /var/www/html

   # Install required dependencies
   RUN apt-get update && apt-get install -y \
       git \
       curl \
       zip \
       unzip \
       nginx

   # Clone the Pterodactyl repository
   RUN git clone https://github.com/pterodactyl/panel.git .

   # Install PHP dependencies
   RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
   RUN composer install --no-dev --optimize-autoloader

   # Expose the port used by Pterodactyl (default: 80)
   EXPOSE 80

   # Start the PHP built-in server
   CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=80"]
