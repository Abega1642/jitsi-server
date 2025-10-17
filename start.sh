#!/bin/bash
set -e

echo "Starting Jitsi Meet..."

PUBLIC_URL="${PUBLIC_URL:-https://localhost}"
XMPP_DOMAIN="${XMPP_DOMAIN:-meet.jitsi}"

echo "Using PUBLIC_URL: $PUBLIC_URL"
echo "Using XMPP_DOMAIN: $XMPP_DOMAIN"

echo "Configuring web interface..."
if [ -f /defaults/config.js ]; then
    cp /defaults/config.js /config/config.js
    ESCAPED_PUBLIC_URL=$(echo "$PUBLIC_URL" | sed 's/[\/&]/\\&/g')
    ESCAPED_XMPP_DOMAIN=$(echo "$XMPP_DOMAIN" | sed 's/[\/&]/\\&/g')
    
    sed -i "s/{{XMPP_DOMAIN}}/${ESCAPED_XMPP_DOMAIN}/g" /config/config.js
    sed -i "s|{{PUBLIC_URL}}|${ESCAPED_PUBLIC_URL}|g" /config/config.js
    
    echo "Configuration applied successfully"
fi

echo "Starting Jitsi services..."
exec /init
