#!/bin/bash

sudo apt update
sudo apt-get install tomcat9 tomcat9-docs tomcat9-admin -y
sudo cp -r /usr/share/tomcat9-admin/* /var/lib/tomcat9/webapps/ -v
sudo chmod 777 /var/lib/tomcat9/conf/tomcat-users.xml
sudo echo "<role rolename="manager-script"/> <user username="tomcat" password="password" roles="manager-script"/>" > /var/lib/tomcat9/conf/tomcat-users.xml
sudo systemctl restart tomcat9
