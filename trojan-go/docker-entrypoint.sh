#!/bin/sh
set -e
# wait
cat /etc/$APP_NAME/$APP_NAME.json
echo "waiting for $DOMAIN"
wait-for http://$DOMAIN -- echo "$DOMAIN is ready"
sed -i "s#trojan-go#${APP_NAME}#" /etc/$APP_NAME/$APP_NAME.json
sed -i "s#your_password#${PASSWORD}#" /etc/$APP_NAME/$APP_NAME.json
sed -i "s#127.0.0.1#caddy#" /etc/$APP_NAME/$APP_NAME.json
# sed -i "s#80#443#" /etc/$APP_NAME/$APP_NAME.json
CERT_PATH=/root/.local/share/caddy/certificates/acme-v02.api.letsencrypt.org-directory/$DOMAIN/$DOMAIN.crt
KEY_PATH=/root/.local/share/caddy/certificates/acme-v02.api.letsencrypt.org-directory/$DOMAIN/$DOMAIN.key
sed -i "s#your_cert.crt#${CERT_PATH}#" /etc/$APP_NAME/$APP_NAME.json
sed -i "s#your_key.key#${KEY_PATH}#" /etc/$APP_NAME/$APP_NAME.json
sed -i "s#your-domain-name.com#${DOMAIN}#" /etc/$APP_NAME/$APP_NAME.json
cat /etc/$APP_NAME/$APP_NAME.json

# run
$APP_NAME -config /etc/$APP_NAME/$APP_NAME.json