#!/bin/bash
set -e

if [ ! -f /config/.jitsi-secrets ]; then
    echo "Generating Jitsi secrets..."
    export JICOFO_COMPONENT_SECRET=$(openssl rand -hex 16)
    export JICOFO_AUTH_PASSWORD=$(openssl rand -hex 16)
    export JVB_AUTH_PASSWORD=$(openssl rand -hex 16)
    
    cat > /config/.jitsi-secrets << EOF
JICOFO_COMPONENT_SECRET=$JICOFO_COMPONENT_SECRET
JICOFO_AUTH_PASSWORD=$JICOFO_AUTH_PASSWORD
JVB_AUTH_PASSWORD=$JVB_AUTH_PASSWORD
EOF
else
    echo "Loading existing secrets..."
    source /config/.jitsi-secrets
fi

export PUBLIC_URL=${PUBLIC_URL:-https://localhost}
export XMPP_DOMAIN=${XMPP_DOMAIN:-meet.jitsi}
export XMPP_SERVER=${XMPP_SERVER:-xmpp.meet.jitsi}

echo "Configuring Prosody..."
sed -i "s/{{XMPP_DOMAIN}}/$XMPP_DOMAIN/g" /etc/prosody/prosody.cfg.lua
sed -i "s/{{JICOFO_COMPONENT_SECRET}}/$JICOFO_COMPONENT_SECRET/g" /etc/prosody/prosody.cfg.lua

echo "Configuring web interface..."
cp /defaults/config.js /config/config.js
sed -i "s/{{XMPP_DOMAIN}}/$XMPP_DOMAIN/g" /config/config.js
sed -i "s/{{PUBLIC_URL}}/$PUBLIC_URL/g" /config/config.js

echo "Configuring nginx..."
sed -i "s/{{PUBLIC_URL}}/$PUBLIC_URL/g" /etc/nginx/sites-available/meet.conf

echo "Starting services..."

echo "Starting Prosody..."
prosodyctl start

echo "Starting JVB..."
export JVB_SECRET=$JVB_AUTH_PASSWORD
service jitsi-videobridge2 start

echo "Starting Jicofo..."
export JICOFO_SECRET=$JICOFO_AUTH_PASSWORD
service jicofo start

echo "Starting nginx..."
nginx -g 'daemon off;' &

wait
