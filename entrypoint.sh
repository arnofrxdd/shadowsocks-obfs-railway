#!/bin/bash

set -e

echo "[+] Starting strongSwan (IKEv2 VPN)..."
ipsec restart

echo "[+] Waiting for VPN tunnel to establish..."
sleep 5

echo "[+] Bringing up the tunnel..."
ipsec up myvpn || echo "[!] VPN setup failed"

echo "[+] Checking VPN status..."
ipsec statusall || echo "[!] VPN status failed"

echo "[+] Checking current IP (via VPN)..."
curl -s https://icanhazip.com || echo "[!] curl failed - no internet or VPN broken"

echo "[+] Waiting before routing..."
sleep 5

echo "[+] Adding default route via VPN..."
ip route flush table main || echo "[!] Failed to flush route table"
ip route add default dev ipsec0 || echo "[!] Failed to add default route"

echo "[+] Launching Shadowsocks with obfs..."
ss-server -c /etc/shadowsocks/shadowsocks.json --plugin obfs-server --plugin-opts "obfs=http"
