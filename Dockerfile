FROM alpine:edge

ARG AUUID="aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"

COPY ./etc/Caddyfile /tmp/Caddyfile
COPY ./etc/xray_config.json /tmp/xray_config.json
COPY ./start.sh /start.sh

RUN apk update && \
    mkdir /opt/caddy && \
    mkdir /opt/xray && \
    wget -O /opt/caddy https://github.com/caddyserver/caddy/releases/download/v2.4.6/caddy_2.4.6_linux_amd64.tar.gz && \
    wget -O /opt/xray https://github.com/XTLS/Xray-core/releases/download/v1.5.4/Xray-linux-64.zip && \
    wget -O /var/mikutap-master.zip https://github.com/AYJCSGM/mikutap/archive/refs/heads/master.zip && \
    tar -zxvf /opt/caddy/caddy_2.4.6_linux_amd64.tar.gz && \
    unzip /opt/xray Xray-linux-64.zip && \
    unzip /var/mikutap-master.zip && \
    mv /tmp/Caddyfile /opt/caddy/Caddyfile && \
    cat /tmp/xray_config.json | sed -e "s/\$AUUID/$AUUID/g" >/opt/xray/xray_config.json && \
    mv /var/mikutap-master /var/html && \
    chmod +x /start.sh

ENTRYPOINT /start.sh
