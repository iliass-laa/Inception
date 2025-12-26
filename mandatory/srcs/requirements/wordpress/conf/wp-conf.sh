#!/bin/bash


wait_for_mariadb() {
    echo "Waiting for MariaDB to be ready..."
    while ! mysqladmin ping -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" --silent; do
        echo "MariaDB is unavailable - sleeping"
        sleep 5
    done
    echo "MariaDB is up and running!"
}

wait_for_mariadb
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Installing WordPress..."
    
    mkdir -p /var/www/html
    curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz
    tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1
    rm /tmp/wordpress.tar.gz

    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/" /var/www/html/wp-config.php
    sed -i "s/username_here/${WORDPRESS_DB_USER}/" /var/www/html/wp-config.php
    sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/" /var/www/html/wp-config.php
    sed -i "s/localhost/${WORDPRESS_DB_HOST}/" /var/www/html/wp-config.php
fi


if ! wp core is-installed --allow-root; then
    echo "Installing WordPress..."

    wp core install \
        --url="https://ilaasri.42.fr" \
        --title="Inception WP" \
        --admin_user="$WP_ADMIN_N" \
        --admin_password="$WP_ADMIN_PSWD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root

    wp user create \
        "$WP_USER_N" "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PSWD" \
        --role=editor \
        --allow-root
else
    echo "WordPress already installed."
    echo "WordPress already installed."
    echo "WordPress already installed."
fi

chown -R www-data:www-data /var/www/html

mkdir -p /run/php
sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

php-fpm7.4 -F
