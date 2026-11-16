#!/bin/sh
set -eu

CFG="/etc/network/interfaces.d/50-cloud-init.cfg"

echo "[stage0] Enabling DHCP on eth1..."

if [ ! -f "$CFG" ]; then
    echo "[stage0] ERROR: $CFG not found"
    exit 1
fi

if grep -q '^iface eth1 inet manual$' "$CFG"; then
    sed -i 's/^iface eth1 inet manual$/iface eth1 inet dhcp/' "$CFG"
else
    echo "[stage0] WARNING: Expected eth1 manual configuration not found."
    grep -n 'eth1' "$CFG" || true
fi

ifdown --force eth1 2>/dev/null || true
ifup eth1

echo
echo "[stage0] Network:"
ip -br addr show eth1

echo
echo "[stage0] Done. Continue via SSH."