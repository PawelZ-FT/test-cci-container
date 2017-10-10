FROM alpine
MAINTAINER PawelZ

RUN apk update && apk upgrade && \
    apk add --no-cache openjdk8 ca-certificates openssl && \
    rm -rf /var/cache/apk/*

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk


COPY files/apache-tomcat* /tmp/apache-tomcat.tgz
COPY files/container-entry.sh /container-entry.sh
COPY files/ec2-metadata /usr/local/bin/ec2-metadata

ENTRYPOINT ["/container-entry.sh"]
