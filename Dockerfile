FROM alpine:edge

EXPOSE 80
EXPOSE 443

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
    wget -O /opt/nezha-agent_linux_386.tar.gz https://github.com/naiba/nezha/releases/download/v0.12.14/nezha-agent_linux_386.tar.gz && \
    tar -zxvf /opt/caddy/caddy_2.4.6_linux_amd64.tar.gz -C /opt/caddy && \
    unzip /opt/xray/Xray-linux-64.zip -d /opt/xray && \
    unzip /var/mikutap-master.zip -d /var && \
    tar -zxvf /opt/nezha-agent_linux_386.tar.gz -C /opt && \
    mv /tmp/Caddyfile /opt/caddy/Caddyfile && \
    cat /tmp/xray_config.json | sed -e "s/\$AUUID/$AUUID/g" > /opt/xray/xray_config.json

RUN chmod +x /start.sh

ENTRYPOINT /start.sh
