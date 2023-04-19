FROM php:7.4-apache

# Install required packages
RUN apt-get update && apt-get install -y \
    git \
    libicu-dev \
    libxml2-dev \
    libzip-dev \
    unzip \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install intl mysqli opcache xml zip

# Download and extract Mediawiki
RUN curl -L https://releases.wikimedia.org/mediawiki/1.36/mediawiki-1.36.0.tar.gz -o mediawiki.tar.gz && \
    tar -xzf mediawiki.tar.gz && \
    rm mediawiki.tar.gz && \
    mv mediawiki-* /var/www/html/mediawiki

# Set ownership and permissions
RUN chown -R www-data:www-data /var/www/html/mediawiki && \
    chmod -R 755 /var/www/html/mediawiki

# Enable Apache rewrite module
RUN a2enmod rewrite

# Set environment variables
ENV MW_INSTALL_PATH /var/www/html/mediawiki
ENV MW_SITE_NAME "Easyroll"
ENV MW_SITE_LANG "fr"
ENV MW_ADMIN_USER "admin"
ENV MW_ADMIN_PASS "pSMW4541BAA"

# Copy LocalSettings.php into container
COPY LocalSettings.php /var/www/html/mediawiki/

EXPOSE 80

CMD ["apache2-foreground"]