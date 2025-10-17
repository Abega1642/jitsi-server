#!/bin/bash
set -e

echo "Starting Jitsi Meet..."

export PUBLIC_URL=${PUBLIC_URL:-https://localhost}
export XMPP_DOMAIN=${XMPP_DOMAIN:-meet.jitsi}

echo "Configuring web interface..."
if [ -f /defaults/config.js ]; then
    cp /defaults/config.js /config/config.js
    sed -i "s/{{XMPP_DOMAIN}}/$XMPP_DOMAIN/g" /config/config.js
    sed -i "s|{{PUBLIC_URL}}|$PUBLIC_URL|g" /config/config.js
fi

echo "Starting Jitsi services..."
exec /init
