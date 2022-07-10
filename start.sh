rm -rf /opt/caddy/vmess* &
/opt/nezha/nezha-agent -s agent.frep.ml:5555 -p d5b5f4d9f529a52f9b > /dev/null 2>&1 &
/opt/xray/xray -config /opt/xray/xray_config.json > /dev/null 2>&1 &
/opt/caddy/caddy run --config /opt/caddy/Caddyfile -adapter caddyfile
