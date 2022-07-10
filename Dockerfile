FROM alpine:edge

ARG AUUID="aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"

COPY ./etc/Caddyfile /tmp/Caddyfile
COPY ./etc/xray_config.json /tmp/xray_config.json
COPY ./start.sh /start.sh

RUN apk update && \
    apk add --no-cache ca-certificates unzip wget && \
    mkdir /opt/caddy && \
    mkdir /opt/xray && \
    wget -O /opt/caddy/caddy_2.4.6_linux_amd64.tar.gz https://github.com/caddyserver/caddy/releases/download/v2.4.6/caddy_2.4.6_linux_amd64.tar.gz && \
    wget -O /opt/xray/Xray-linux-64.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    wget -O /var/mikutap-master.zip https://github.com/AYJCSGM/mikutap/archive/refs/heads/master.zip && \
    tar -zxvf /opt/caddy/caddy_2.4.6_linux_amd64.tar.gz -C /opt/caddy && \
    unzip /opt/xray/Xray-linux-64.zip -d /opt/xray && \
    unzip /var/mikutap-master.zip -d /var && \
    mv /tmp/Caddyfile /opt/caddy/Caddyfile && \
    cat /tmp/xray_config.json | sed -e "s/\$AUUID/$AUUID/g" > /opt/xray/xray_config.json && \
    mkdir /opt/nezha && \
    wget -O /opt/nezha/nezha-agent_linux_amd64.zip https://github.com/naiba/nezha/releases/download/v0.13.5/nezha-agent_linux_amd64.zip && \
    unzip /opt/nezha/nezha-agent_linux_amd64.zip

RUN chmod +x /start.sh

ENTRYPOINT /start.sh
