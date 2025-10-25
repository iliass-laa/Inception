#!/bin/bash

cd /var/www/html/
wget https://www.adminer.org/latest.php -O adminer.php

chown -R www-data:www-data /var/www/html/adminer.php
chmod 644 /var/www/html/adminer.php


tail -f /dev/null