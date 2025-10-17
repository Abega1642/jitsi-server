FROM jitsi/web:web-1.0.8887-1

RUN echo '#!/bin/sh\nexit 101' > /usr/sbin/policy-rc.d && \
    chmod +x /usr/sbin/policy-rc.d

RUN apt-get update && apt-get install -y --no-install-recommends \
    prosody \
    jitsi-meet-prosody \
    jicofo \
    jitsi-videobridge2 \
    && rm -rf /var/lib/apt/lists/*

RUN rm -f /usr/sbin/policy-rc.d

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
