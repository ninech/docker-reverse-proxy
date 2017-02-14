FROM ubuntu:xenial
MAINTAINER Samuel Sieg samuel.sieg@nine.ch

RUN mkdir -p /run/apache2

RUN apt-get -qq update && \
    apt-get -qq install -y apache2 \
    libapache2-mod-auth-cas \
    ruby && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

RUN a2enmod proxy proxy_http remoteip auth_cas
RUN a2dissite 000-default

COPY docker /docker/
WORKDIR /docker

EXPOSE 8080

CMD ["./start.sh"]
