VirtualHost "{{XMPP_DOMAIN}}"
    authentication = "anonymous"
    ssl = {
        key = "/config/certs/{{XMPP_DOMAIN}}.key";
        certificate = "/config/certs/{{XMPP_DOMAIN}}.crt";
    }
    modules_enabled = {
        "bosh";
        "websocket";
        "smacks";
        "pubsub";
        "ping";
        "speakerstats";
        "conference_duration";
    }
    c2s_require_encryption = false

Component "conference.{{XMPP_DOMAIN}}" "muc"
    modules_enabled = {
        "muc_mam"
    }
    storage = "memory"
    restrict_room_creation = false

Component "jitsi-videobridge.{{XMPP_DOMAIN}}"
    component_secret = "{{JICOFO_COMPONENT_SECRET}}"

Component "focus.{{XMPP_DOMAIN}}"
    component_secret = "{{JICOFO_COMPONENT_SECRET}}"
