#!/bin/bash

service mariadb start
sleep 3

#--------------mariadb config--------------#
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB_N}\`;"
mariadb -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mariadb -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DB_N}\`.* TO \`${MYSQL_USER}\`@'%';"
mariadb -e "FLUSH PRIVILEGES;"

# Shutdown to restart with clean config
mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

# Continue with container CMD
exec "$@"
