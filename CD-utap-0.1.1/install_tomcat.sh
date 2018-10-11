#!/bin/sh
unlink /opt/tomcat
# rmdir /opt/tomcat
# rm -rf /opt/apache-tomcat*

cd /tmp
# wget http://www-eu.apache.org/dist/tomcat/tomcat-8/v8.5.34/bin/apache-tomcat-8.5.33.tar.gz
# tar -xzf apache-tomcat-8.5.34.tar.gz -C /opt/
ln -s /opt/apache-tomcat-8.5.34 /opt/tomcat
