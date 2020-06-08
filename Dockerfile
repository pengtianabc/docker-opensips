FROM debian:stretch
MAINTAINER pengtianabc

USER root
ENV DEBIAN_FRONTEND noninteractive

ARG VERSION=3.0
ARG BUILD=nightly

RUN apt-get update -qq && apt-get install -y gnupg2

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 049AD65B
RUN echo "deb http://apt.opensips.org jessie $VERSION-$BUILD" >/etc/apt/sources.list.d/opensips.list

RUN apt-get update -qq && apt-get install -y opensips

RUN sed -i "s/RUN_OPENSIPS=no/RUN_OPENSIPS=yes/g" /etc/default/opensips
RUN sed -i "s/DAEMON=\/sbin\/opensips/DAEMON=\/usr\/sbin\/opensips/g" /etc/init.d/opensips

RUN apt install wget -y
RUN wget http://de.archive.ubuntu.com/ubuntu/pool/main/j/json-c/libjson-c2_0.11-3ubuntu1.2_amd64.deb -O libjson-c2_0.11-3ubuntu1.2_amd64.deb
RUN dpkg -i libjson-c2_0.11-3ubuntu1.2_amd64.deb
RUN wget http://de.archive.ubuntu.com/ubuntu/pool/main/j/json-c/libjson-c2_0.11-3ubuntu1.2_amd64.deb -O libjson-c2_0.11-3ubuntu1.2_amd64.deb
RUN dpkg -i libjson-c2_0.11-3ubuntu1.2_amd64.deb
RUN wget http://security.debian.org/debian-security/pool/updates/main/h/hiredis/libhiredis0.10_0.11.0-4+deb8u1_amd64.deb -O libhiredis0.10_0.11.0-4+deb8u1_amd64.deb
RUN dpkg -i libhiredis0.10_0.11.0-4+deb8u1_amd64.deb
RUN apt install opensips-json-module opensips-restclient-module opensips-redis-module -y

EXPOSE 5060/udp

COPY run.sh /run.sh

ENTRYPOINT ["/run.sh"]
