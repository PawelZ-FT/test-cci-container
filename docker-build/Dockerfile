FROM alpine
MAINTAINER PawelZ

COPY files/apache-tomcat* /tmp/apache-tomcat.tgz
COPY files/container-entry.sh /container-entry.sh
COPY files/ec2-metadata /usr/local/bin/ec2-metadata

RUN apk update && apk upgrade && \
    apk add --no-cache openjdk8 ca-certificates openssl && \
    rm -rf /var/cache/apk/* && \
    mkdir /usr/local/tomcat && \
    mkdir /var/log/tomcat && \
    tar zxf /tmp/apache-tomcat.tgz --strip-components=1 -C /usr/local/tomcat && \
    rm -rf /usr/local/tomcat/webapps && \
    rm -rf /usr/local/tomcat/logs


ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/bin


ENTRYPOINT ["/container-entry.sh"]
