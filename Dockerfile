FROM alpine:3.9

RUN apk --update add wget nginx openssl dnsmasq bash

RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
  && mkdir -p /run/nginx \
  && sed -i 's/# server_names_hash_bucket/server_names_hash_bucket/g' /etc/nginx/nginx.conf

RUN wget https://github.com/jwilder/forego/releases/download/v0.16.1/forego \
 && mv forego /usr/local/bin/forego \
 && chmod u+x /usr/local/bin/forego

ENV DOCKER_GEN_VERSION 0.7.4

RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
  && tar xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
  && mv docker-gen /usr/local/bin/docker-gen \
  && chmod +x /usr/local/bin/docker-gen

WORKDIR /src
COPY . .

RUN echo user=root >> /etc/dnsmasq.conf \
  && dnsmasq \
  && chmod +x start.sh

EXPOSE 80 443
ENV DOCKER_HOST unix:///tmp/docker.sock

CMD ["forego", "start", "-r"]
