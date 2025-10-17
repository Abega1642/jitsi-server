var config = {
    hosts: {
        domain: "{{XMPP_DOMAIN}}",
        muc: "conference.{{XMPP_DOMAIN}}",
        bridge: "jitsi-videobridge.{{XMPP_DOMAIN}}",
        focus: "focus.{{XMPP_DOMAIN}}",
    },

    bosh: "//{{PUBLIC_URL}}/http-bind",
    websocket: "wss://{{PUBLIC_URL}}/xmpp-websocket",

    useStunTurn: false,
    enableIceRestart: false,

    disableThirdPartyRequests: true,
    enableLayerSuspension: true,

    defaultLanguage: "en",
    prejoinPageEnabled: false,

    constraints: {
        video: {
            height: { ideal: 360, max: 720, min: 180 },
        },
    },

    disableAGC: true,
    enableNoAudioDetection: true,
    enableSaveLogs: false,
};

config.iceTransportPolicy = "relay";
config.p2p = { enabled: false };
