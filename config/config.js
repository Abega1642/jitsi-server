var config = {
    hosts: {
        domain: "meet.jitsi",
        muc: "conference.meet.jitsi",
        bridge: "jitsi-videobridge.meet.jitsi",
        focus: "focus.meet.jitsi",
    },

    bosh: "//jitsi-server-21kh.onrender.com/http-bind",
    websocket: "wss://jitsi-server-21kh.onrender.com/xmpp-websocket",

    openBridgeChannel: "websocket",
    enableWebsocket: true,

    useStunTurn: false,
    enableIceRestart: true,
    p2p: { enabled: true },

    disableThirdPartyRequests: true,
    enableNoAudioDetection: true,
    resolution: 360,

    defaultLanguage: "en",
    prejoinPageEnabled: true,
    startAudioOnly: false,
    startWithAudioMuted: false,
    startWithVideoMuted: false,
};
