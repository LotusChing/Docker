FROM ubuntu:14.04
RUN mv /etc/apt/sources.list /etc/apt/sources.list.default
ADD aliyun.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update
RUN apt-get -y install openjdk-7-jdk
RUN apt-get -y install lrzsz curl wget

# Locale
RUN apt-get -y install locales
RUN echo "C.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "export LC_ALL=C.UTF-8" >> ~/.bashrc
RUN echo "export LANG=C.UTF-8" >> ~/.bashrc
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Timezone
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
RUN echo "Asia/Chongqing" > /etc/timezone
ENV TZ Asia/Shanghai

## Initial JDK
ENV JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
RUN echo "export JAVA_HOME=$JAVA_HOME" >> /etc/profile
RUN echo "export JAVA_HOME=$JAVA_HOME" >> ~/.bashrc


## Initial Jstat Remote Interface
RUN echo 'grant codebase "file:$JAVA_HOME/lib/tools.jar" {\n\
    permission java.security.AllPermission;\n\
};' > /etc/jstatd.all.policy


# Create Tomcat User
RUN groupadd -g 999 tomcat && \
    useradd -m -r -u 999 -g tomcat -m -d /usr/local/tomcat/ tomcat



# Tomcat
## Install
RUN wget https://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-7/v7.0.91/bin/apache-tomcat-7.0.91.tar.gz -O /tmp/tomcat.tgz && \
    tar xf /tmp/tomcat.tgz  -C /usr/local/tomcat --strip-components 1 && \
    rm -f /tmp/tomcat.tgz && \
    chown -R tomcat.tomcat /usr/local/tomcat/


## Config
### Basic User Auth
RUN mv /usr/local/tomcat/conf/tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml.default
RUN echo '<?xml version="1.0" encoding="UTF-8"?>\n\
<tomcat-users>\n\
  <role rolename="manager-gui"/>\n\
  <role rolename="manager-script"/>\n\
  <role rolename="manager-jmx"/>\n\
  <role rolename="manager-status"/>\n\
  <role rolename="admin-gui"/>\n\
  <role rolename="admin-script"/>\n\
  <user username="USERNAME" password="PASSWORD" roles="manager-gui,manager-script,manager-jmx,manager-status,admin-gui,admin-script"/>\n\
</tomcat-users>' > /usr/local/tomcat/conf/tomcat-users.xml

### Tomcat Basic
RUN sed -r -i 's/port="8080"/port="8080" URIEncoding="UTF-8"/g' /usr/local/tomcat/conf/server.xml
RUN sed -i '2iexport CATALINA_OPTS="$CATALINA_OPTS -Duser.timezone=Asia/Shanghai -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=1099 -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.authenticate=false"' /usr/local/tomcat/bin/catalina.sh


# Container Basic
WORKDIR /usr/local/tomcat
ADD entrypoint.sh /
CMD ["/entrypoint.sh"]
