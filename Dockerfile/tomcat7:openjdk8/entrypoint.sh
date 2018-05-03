#!/bin/bash
echo "Starting Jstatd..."
nohup jstatd -J-Djava.security.policy=/etc/jstatd.all.policy -p 2010 > /var/log/jstatd.log 2>&1 &
echo "Staring Tomcat..."
/usr/local/tomcat/bin/startup.sh && tail -f /usr/local/tomcat/logs/catalina.out
