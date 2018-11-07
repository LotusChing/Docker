#!/bin/bash
echo "Starting Jstatd..."
su tomcat -c "nohup jstatd -J-Djava.security.policy=/usr/local/tomcat/conf/jstatd.all.policy -p 2010 > /usr/local/tomcat/logs/jstatd.log 2>&1 &"
echo "Staring Tomcat..."
chown -R tomcat.tomcat /usr/local/tomcat
su tomcat -c "/usr/local/tomcat/bin/startup.sh && tail -f /usr/local/tomcat/logs/catalina.out"
