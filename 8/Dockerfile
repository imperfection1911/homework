FROM openjdk:8-jre-slim
MAINTAINER Anton Aksenov <imperfection1911@gmail.com>
ARG JMETER_VERSION=3.0
RUN apt-get update \
	&& apt-get -qy install wget telnet unzip \ 
	&& rm -rf /var/lib/apt/lists/*  \
    	&& mkdir /jmeter \ 
	&& cd /jmeter \
	&& wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz \
   	&& tar -xvzf apache-jmeter-$JMETER_VERSION.tgz \ 
	&& rm apache-jmeter-$JMETER_VERSION.tgz \ 
	&& sed -i 's/#server_port=1099/server_port=55511/g' /jmeter/apache-jmeter-$JMETER_VERSION/bin/jmeter.properties \
	&& sed -i 's/#server.rmi.localport=4000/server.rmi.localport=4000/g' /jmeter/apache-jmeter-$JMETER_VERSION/bin/jmeter.properties \
	&& groupadd -r jmeter && useradd -r -g jmeter jmeter
COPY lib/* /jmeter/apache-jmeter-$JMETER_VERSION/lib/
EXPOSE 55511 4000
WORKDIR /jmeter/apache-jmeter-$JMETER_VERSION
USER jmeter
ENTRYPOINT ./bin/jmeter-server -Djava.rmi.server.hostname=$SERVER_HOSTNAME
