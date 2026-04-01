#!/bin/bash
yum install -y httpd
systemctl start httpd.service
systemctl enable httpd.service

# phpのインストール
amazon-linux-extras install -y php8.2
yum install -y php-mbstring php-gd
systemctl restart httpd.service

# WordPressのインストール
cd ~
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp wordpress/wp-config-sample.php wordpress/wp-config.php
cp -r wordpress/* /var/www/html/
chown -R apache:apache /var/www/html/

systemctl restart httpd.service