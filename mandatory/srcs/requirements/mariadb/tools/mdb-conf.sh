#!/bin/bash

service mariadb start
sleep 3


mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB_N}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DB_N}\`.* TO \`${MYSQL_USER}\`@'%';"
mysql -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

exec "$@"


