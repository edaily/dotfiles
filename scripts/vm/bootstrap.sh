#!/usr/bin/env bash
# Finalize VM bootstrap

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../common/ssh-utils.sh"

# Configuration
NIXADDR="${NIXADDR:-192.168.2.130}"
NIXPORT="${NIXPORT:-22}"
NIXUSER="${NIXUSER:-eugene}"

echo "Finalizing VM bootstrap..."

# Run copy as root
NIXUSER=root "${SCRIPT_DIR}/copy.sh"

# Run switch as root
NIXUSER=root "${SCRIPT_DIR}/switch.sh"

# Copy secrets
"${SCRIPT_DIR}/secrets.sh"

# Reboot
echo "Rebooting VM..."
ssh $SSH_OPTIONS -p${NIXPORT} ${NIXUSER}@${NIXADDR} " \
    sudo reboot; \
"

echo "VM bootstrap complete"
