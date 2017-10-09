FROM alpine
MAINTAINER PawelZ

RUN apk update && apk upgrade


COPY files/container-entry.sh /container-entry.sh
COPY files/ec2-metadata /usr/local/bin/ec2-metadata

ENTRYPOINT ["/container-entry.sh"]
