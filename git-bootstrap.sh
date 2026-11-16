#!/bin/bash
set -euo pipefail

KEY="/root/.ssh/iac"

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  git \
  openssh-client \
  ca-certificates

mkdir -p /root/.ssh
chmod 700 /root/.ssh

if [ ! -f "$KEY" ]; then
    ssh-keygen -t ed25519 -f "$KEY" -N "" -C "n-rs-2-iac"
fi

echo
echo "=== Deploy Key ==="
cat "${KEY}.pub"
echo
echo "Diesen Key jetzt als READ-ONLY Deploy Key im privaten Repo hinterlegen."