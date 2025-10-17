FROM jitsi/web:web-1.0.8887-1

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY config/config.js /defaults/config.js
COPY start.sh /start.sh

RUN chmod +x /start.sh && \
    mkdir -p /config /config/certs /config/web

EXPOSE 80 443

HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

CMD ["/start.sh"]
