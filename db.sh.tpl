#!/bin/bash

# NATゲートウェイの設定前に実行されるので、これらの処理は意味ないのでは？

yum install -y mariadb-server
systemctl start mariadb.service
systemctl enable mariadb.service
mysql -u root -p <<EOF
CREATE USER '${DB_USER}' IDENTIFIED BY '${DB_PASSWORD}';
CREATE DATABASE ${DB_NAME} CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}';
FLUSH PRIVILEGES;
EOF