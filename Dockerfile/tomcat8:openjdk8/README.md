# Dockerfile 说明

镜像除了基础的JAVA环境及Tomcat外，默认配置并启动Jstatd服务，主要目的是暴露接口以便监控系统获取容器内Tomcat JVM运行状态，需要特别说明的是jstatd没有配置特殊的rminame，所以如果暴露在公网或者不安全的内网可能会有风险

如果比较在意安全方便的考虑，可以修改entrypoint.sh中jstatd启动命令，修改为
`nohup jstatd -J-Djava.security.policy=/etc/jstatd.all.policy -p 2010 -n rminame > /var/log/jstatd.log 2>&1 &`

获取JVM状态数据，更多用法见**其他**下的链接，OpenJDK官网没有找到相关文档，
1. jps rmi://container_ip:2010</rminame>
2. jstat -gc rmi:vmid@container_ip:2010</rminame>

## 软件
1. Ubuntu 14.04 基础镜像
2. OpenJDK 8
3. apache-tomcat-8.0.53

## 配置
1. timezone时区配置
2. locale语言环境配置
2. OpeJDK基础配置
3. Tomcat基础配置、用户配置、基础安全配置(详见配置)
4. Jstatd授权配置

## 服务暴露
1. Tomcat服务 tcp:8080
2. Jstatd远程接口 tcp:2010

## 其他
* Jps: https://www.systutorials.com/docs/linux/man/1-jps-java-1.8.0-openjdk-1.8.0.65-3.b17.fc22.x86_64/
* Jstat: https://www.systutorials.com/docs/linux/man/1-jps-java-1.8.0-openjdk-1.8.0.65-3.b17.fc22.x86_64/
* Jstatd: https://www.systutorials.com/docs/linux/man/1-jstatd-java-1.8.0-openjdk-1.8.0.65-3.b17.fc22.x86_64/

