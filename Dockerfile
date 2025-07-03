# === Dockerfile ===
FROM debian:bullseye

# Install dependencies
RUN apt-get update && apt-get install -y \
    iproute2 iptables shadowsocks-libev \
    strongswan strongswan-plugin-eap-mschapv2 \
    libstrongswan-extra-plugins \
    obfs4proxy curl tini && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy config files
COPY entrypoint.sh /entrypoint.sh
COPY shadowsocks.json /etc/shadowsocks-libev/config.json
COPY ipsec.conf /etc/ipsec.conf
COPY ipsec.secrets /etc/ipsec.secrets

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
