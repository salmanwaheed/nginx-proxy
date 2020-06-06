FROM alpine:3.9

RUN apk --update add wget nginx openssl dnsmasq bash

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
# RUN nginx -g 'pid /tmp/nginx.pid; daemon off;'
RUN mkdir -p /run/nginx

#fix for long server names
RUN sed -i 's/# server_names_hash_bucket/server_names_hash_bucket/g' /etc/nginx/nginx.conf

ADD https://github.com/jwilder/forego/releases/download/v0.16.1/forego /usr/local/bin/forego
RUN chmod u+x /usr/local/bin/forego

ENV DOCKER_GEN_VERSION 0.7.4

RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz
RUN tar xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz
RUN mv docker-gen /usr/local/bin/docker-gen
RUN chmod +x /usr/local/bin/docker-gen

ENV SRC_DIR /src

RUN mkdir $SRC_DIR
WORKDIR $SRC_DIR
ADD . $SRC_DIR

RUN echo user=root >> /etc/dnsmasq.conf
RUN dnsmasq
RUN chmod +x start.sh

EXPOSE 80
EXPOSE 443
ENV DOCKER_HOST unix:///tmp/docker.sock

CMD ["forego", "start", "-r"]
