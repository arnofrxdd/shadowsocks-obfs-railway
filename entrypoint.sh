#!/bin/bash
set -e

echo "[+] Starting OpenVPN..."
openvpn --config /etc/openvpn/vpn.ovpn --auth-user-pass <(echo -e "vpn\nvpn") &

echo "[+] Waiting for VPN to establish..."
sleep 10

echo "[+] Checking external IP (via VPN)..."
curl -s https://icanhazip.com || echo "IP check failed"

echo "[+] Starting Shadowsocks with obfs..."
ss-server -c /etc/shadowsocks/shadowsocks.json \
  --plugin obfs-server --plugin-opts "obfs=http" &
wait
