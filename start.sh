netstat -nr | grep '^0\.0\.0\.0' | awk '{print $2 " host"}' >> /etc/hosts
dnsmasq
docker-gen -watch -only-exposed -notify "nginx -s reload" /src/default.tmpl /etc/nginx/conf.d/default.conf
