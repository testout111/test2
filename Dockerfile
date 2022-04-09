FROM alpine:edge

ARG AUUID="aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"

ADD etc/Caddyfile /tmp/Caddyfile
ADD etc/xray_config.json /tmp/xray_config.json

RUN apk update && \
    apk add --no-cache ca-certificates caddy wget && \
    mkdir /opt/xray && \
    mkdir -p /opt/caddy/html && \
    wget -O /tmp/Xray-linux-64.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip /tmp/Xray-linux-64.zip && \
    mv /tmp/xray /opt/xray/ && \
    chmod +x /opt/xray/xray && \
    wget -O /tmp/mikutap.zip https://github.com/AYJCSGM/mikutap/archive/master.zip
    unzip /tmp/mikutap.zip && \
    mv /tmp/mikutap-master/* /opt/caddy/html && \
    mv /tmp/Caddyfile /opt/caddy/ && \
    cat /tmp/xray_config.json | sed -e "s/\$AUUID/$AUUID/g" >/opt/xray/xray_config.json
    echo "/opt/xray/xray -config /opt/xray/xray_config.json > /dev/null 2>&1 &" > /start.sh
    echo "caddy run --config /opt/caddy/caddyfile --adapter caddyfile > /dev/null 2>&1 &" >start.sh
    
RUN chmod +x /start.sh

CMD /start.sh
