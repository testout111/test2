FROM alpine:edge

ARG AUUID="aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
ARG XRAY="https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip"
ARG HTML="https://github.com/AYJCSGM/mikutap/archive/refs/heads/master.zip"
ARG CADDY="https://github.com/caddyserver/caddy/releases/download/v2.5.2/caddy_2.5.2_linux_amd64.tar.gz"

COPY ./etc/ /tmp/config
COPY ./start.sh /start.sh
RUN apk update && \
    apk add --no-cache ca-certificates unzip wget && \
    mkdir -p /opt/caddy/xray-core && \
    wget -O /tmp/Xray.zip $XRAY && \
    unzip /tmp/Xray.zip -d /tmp/Xray/ && \
    mv /tmp/Xray/xray /opt/caddy/xray-core/ && \
    cat /tmp/config/config.json | sed -e 's/$AUUID/'"${AUUID}"'/g' /opt/caddy/xray-core/config.json && \
    wget -O /tmp/caddy.tar.gz $CADDY && \
    tar -zxf /tmp/caddy.tar.gz -C /tmp/ && \
    mv /tmp/caddy /opt/caddy/ && \
    mv /tmp/config/Caddyfile /opt/caddy/Caddyfile && \
    wget -O /tmp/mikutap-master.zip $HTML && \
    unzip /tmp/mikutap-master.zip -d /opt/caddy/ && \
    chmod +x /opt/caddy/xray-core/xray && \
    chmod +x /start.sh

ENTRYPOINT /start.sh
