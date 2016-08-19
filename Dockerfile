FROM  ubuntu:14.04
MAINTAINER codecetric

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN \
    apt-get update -y && \
    apt-get install -y python python-setuptools jq groff && \
    easy_install pip && \
    pip install awscli

ADD docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
