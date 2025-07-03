FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    openvpn shadowsocks-libev simple-obfs curl tini iproute2 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
COPY shadowsocks.json /etc/shadowsocks/shadowsocks.json
COPY vpn.ovpn /etc/openvpn/vpn.ovpn

ENTRYPOINT ["/entrypoint.sh"]
