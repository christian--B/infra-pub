#!/bin/bash
set -euo pipefail

CFG="/etc/network/interfaces.d/50-cloud-init.cfg"

# eth1 von manual auf DHCP umstellen
sed -i \
  's/^iface eth1 inet manual$/iface eth1 inet dhcp/' \
  "$CFG"

# auto eth1 ergänzen, falls noch nicht vorhanden
if ! grep -qE '^auto[[:space:]]+eth1([[:space:]]|$)' "$CFG"; then
    sed -i '/^iface eth1 inet dhcp$/i auto eth1' "$CFG"
fi

# Interface aktivieren
ifdown --force eth1 2>/dev/null || true
ifup eth1