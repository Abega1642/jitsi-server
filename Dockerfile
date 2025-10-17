FROM jitsi/web:latest

RUN apt-get update && apt-get install -y \
    prosody \
    jitsi-meet-prosody \
    jicofo \
    jitsi-videobridge2 \
    && rm -rf /var/lib/apt/lists/*

COPY config/config.js /defaults/config.js
COPY config/prosody.cfg.lua /etc/prosody/prosody.cfg.lua
COPY config/nginx.conf /etc/nginx/sites-available/meet.conf

COPY start.sh /start.sh
RUN chmod +x /start.sh

RUN mkdir -p /config /config/certs /config/web

EXPOSE 80 443 5222 5269 5347

HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

CMD ["/start.sh"]
