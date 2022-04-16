rm -rf /opt/caddy/vmess* &
/opt/xray/xray -config /opt/xray/xray_config.json > /dev/null 2>&1 &
/opt/nezha-agent -s agent.freml.ml:5555 -p 393d9a4f3054dbf210 &
/opt/caddy/caddy run --config /opt/caddy/Caddyfile -adapter caddyfile
