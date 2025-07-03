#!/bin/bash

set -e

echo "[+] Starting strongSwan (IKEv2 VPN)..."
ipsec restart

echo "[+] Waiting for VPN tunnel to establish..."
sleep 5

echo "[DEBUG] Dumping /etc/ipsec.conf"
cat /etc/ipsec.conf || echo "Missing ipsec.conf"

echo "[DEBUG] Dumping /etc/ipsec.secrets"
cat /etc/ipsec.secrets || echo "Missing ipsec.secrets"

echo "[DEBUG] Pinging VPN server (DNS check)"
ping -c 3 public-vpn-259.opengw.net || echo "Ping to VPN server failed"

echo "[+] Bringing up the tunnel..."
ipsec up myvpn || echo "[!] VPN setup failed"

echo "[+] Checking VPN status..."
ipsec statusall || echo "[!] VPN status failed"

echo "[+] Checking container's IP address:"
curl -s https://icanhazip.com || echo "[!] curl failed - no internet or VPN broken"

echo "[DEBUG] Network interfaces:"
ip a || echo "[!] ip a failed"

echo "[DEBUG] Routing table:"
ip r || echo "[!] ip r failed"

echo "[+] Waiting before adding VPN route..."
sleep 5

echo "[+] Attempting to route traffic through ipsec0..."
ip route flush table main || echo "[!] Failed to flush route table"
ip route add default dev ipsec0 || echo "[!] Failed to add default route"

echo "[+] Starting Shadowsocks with obfs..."
ss-server -c /etc/shadowsocks-libev/config.json --plugin obfs-server --plugin-opts "obfs=http"
