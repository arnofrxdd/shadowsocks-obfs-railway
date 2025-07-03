#!/bin/bash

set -e

echo "[+] Starting strongSwan (IKEv2 VPN)..."
ipsec restart

echo "[+] Waiting for VPN tunnel to establish..."
sleep 5

echo "[+] Bringing up the tunnel..."
ipsec up myvpn

# Optional: Show VPN status
ipsec statusall

echo "[+] Adding default route via VPN..."
# Wait for tunnel interface (usually `ipsec0` or virtual one)
sleep 5

# force all outbound through VPN
ip route flush table main
ip route add default dev ipsec0

echo "[+] Starting Shadowsocks with obfs..."
ss-server -c /etc/shadowsocks/shadowsocks.json --plugin obfs-server --plugin-opts "obfs=http"

