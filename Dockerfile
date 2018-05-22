# This docker file is for creating springboot based websocket
FROM yexianyi/oracle-jdk:centos7


ARG JDK_INSTALL_PATH=/usr/lib/java
ENV CONSUL_AGENT=localhost
ENV JAVA_HOME=$JDK_INSTALL_PATH/jdk1.8.0_131
ENV PATH=$JAVA_HOME/bin:$PATH


MAINTAINER Xianyi Ye <https://cn.linkedin.com/in/yexianyi>

RUN yum update -y \
	&& yum install -y maven \ 
	&& yum install -y git \ 
	&& cd /home \
	&& git clone https://github.com/yexianyi/Chukonu.git \
	&& cd /home/Chukonu/chukonu_consul_api \
	&& mvn clean install -DskipTests \
	&& cd /home/Chukonu/chukonu_springboot_websocket \
	&& mvn clean install -DskipTests \
	&& cp target/springboot-websocket.jar /home/springboot-websocket.jar \
	&& cd /home \
	&& rm -rf Chukonu \
	
	#Uninstall unecessary package
#	&& yum -y remove git \
#	&& yum -y remove maven \
	&& yum clean all \
	&& yum autoremove -y \
	
	#start up commands
	ENTRYPOINT ["java", "-jar", "/home/springboot-websocket.jar"]
	CMD ["server"]
