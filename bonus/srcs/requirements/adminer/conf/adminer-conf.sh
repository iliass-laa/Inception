#!/bin/bash

sudo mkdir -p /var/www/html/adminer
cd /var/www/html/adminer
sudo wget https://www.adminer.org/latest.php -O index.php
sudo chown -R www-data:www-data /var/www/html/adminer
sudo chmod 644 /var/www/html/adminer/index.php



