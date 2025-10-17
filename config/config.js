var config = {
    hosts: {
        domain: "{{XMPP_DOMAIN}}",
        muc: "conference.{{XMPP_DOMAIN}}",
        bridge: "jitsi-videobridge.{{XMPP_DOMAIN}}",
        focus: "focus.{{XMPP_DOMAIN}}",
    },
    bosh: "//{{PUBLIC_URL}}/http-bind",
    websocket: "wss://{{PUBLIC_URL}}/xmpp-websocket",
    openBridgeChannel: "websocket",
    enableWebsocket: true,
    useStunTurn: false,
    p2p: { enabled: true },
    disableThirdPartyRequests: true,
    resolution: 360,
    defaultLanguage: "en",
    prejoinPageEnabled: true,
};

