rm -rf /opt/caddy/vmess &
/opt/xray/xray -config /opt/xray/xray_config.json > /dev/null 2>&1 &
/opt/caddy/caddy run --config /opt/caddy/Caddyfile -adapter caddyfile
