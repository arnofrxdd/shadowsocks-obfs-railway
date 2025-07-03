FROM debian:bullseye

# Set noninteractive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    iproute2 iptables curl tini \
    shadowsocks-libev simple-obfs \
    strongswan libstrongswan-extra-plugins \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy config files
COPY entrypoint.sh /entrypoint.sh
COPY shadowsocks.json /etc/shadowsocks-libev/config.json
COPY ipsec.conf /etc/ipsec.conf
COPY ipsec.secrets /etc/ipsec.secrets

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
