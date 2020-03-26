#!/bin/bash
# get root access
sudo su

# install httpd and apache
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service

# create basic index page
echo "Hello World! This is $(hostname -f)" > /var/www/html/index.html
