FROM alpine
MAINTAINER PawelZ

COPY files/apache-tomcat* /tmp/apache-tomcat.tgz
COPY files/container-entry.sh /container-entry.sh
COPY files/ec2-metadata /usr/local/bin/ec2-metadata

RUN apk update && apk upgrade && \
    apk add --no-cache openjdk8 ca-certificates openssl && \
    rm -rfv /var/cache/apk/* && \
    echo "Adding tomcat user" && \
    adduser -D -s /sbin/nologin -h /usr/local/tomcat tomcat && \
    id tomcat && \
    tar zxvf /tmp/apache-tomcat.tgz --strip-components=1 -C /usr/local/tomcat && \
    rm -v /usr/local/tomcat/bin/*.bat && \
    rm -rfv /usr/local/tomcat/webapps/* && \
    rm -v /tmp/apache-tomcat.tgz && \
    find /usr/local/tomcat/ -perm 640 -exec chmod 644 {} \; && \
    find /usr/local/tomcat/ -perm 750 -exec chmod 755 {} \; && \
    chown -v tomcat. /usr/local/tomcat/webapps && \
    chown -v tomcat. /usr/local/tomcat/work && \
    chown -v tomcat. /usr/local/tomcat/temp && \
    chown -v tomcat. /usr/local/tomcat/logs


ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/bin

USER tomcat

ENTRYPOINT ["/container-entry.sh"]
