#!/bin/bash
sudo yum install java-17-amazon-corretto -y
sudo yum install java-17-amazon-corretto-devel -y
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.25/bin/apache-tomcat-10.1.25.tar.gz
tar xvf apache-tomcat-10.1.25.tar.gz
sudo mv apache-tomcat-10.1.25 /usr/local/tomcat
sudo chown -R  ec2-user:ec2-user /usr/local/tomcat
sudo yum -y install httpd
sudo cat << EOF > /etc/httpd/conf.d/tomcat_manager.conf
<VirtualHost *:80>
    ServerAdmin ec2-user@localhost
    ServerName app.wildrydes.com
    DefaultType text/html
    ProxyRequests off
    ProxyPreserveHost On
    ProxyPass / http://localhost:8080/unicorn-web-project/
    ProxyPassReverse / http://localhost:8080/unicorn-web-project/
</VirtualHost>
EOF
