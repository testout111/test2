FROM alpine:edge

ARG XRAY="https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip"
ARG HTML="https://github.com/AYJCSGM/mikutap/archive/refs/heads/master.zip"
ARG CADDY="https://github.com/caddyserver/caddy/releases/download/v2.5.2/caddy_2.5.2_linux_amd64.tar.gz"

COPY ./etc/Caddyfile /opt/caddy/
COPY ./etc/config.json /opt/caddy/xray-core/
COPY ./start.sh /start.sh
RUN apk update && \
    apk add --no-cache ca-certificates unzip wget && \
    wget -O /tmp/Xray.zip $XRAY && \
    unzip /tmp/Xray.zip -d /tmp/Xray/ && \
    mv /tmp/Xray/xray /opt/caddy/xray-core/ && \
    wget -O /tmp/caddy.tar.gz $CADDY && \
    tar -zxf /tmp/caddy.tar.gz -C /tmp/ && \
    mv /tmp/caddy /opt/caddy/ && \
    wget -O /tmp/mikutap-master.zip $HTML && \
    unzip /tmp/mikutap-master.zip -d /opt/caddy/ && \
    sed -e 's/$AUUID/aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa/g' /opt/caddy/xray-core/config.json && \
    chmod +x /opt/caddy/xray-core/xray && \
    chmod +x /start.sh

ENTRYPOINT /start.sh
