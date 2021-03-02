#! /bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo service httpd start
sudo echo "Hello World" > /var/www/html/index.html
sudo service httpd restart
