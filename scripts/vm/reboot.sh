#!/usr/bin/env bash
# Reboot VM

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../common/ssh-utils.sh"

# Configuration
NIXADDR="${NIXADDR:-192.168.2.130}"
NIXPORT="${NIXPORT:-22}"
NIXUSER="${NIXUSER:-eugene}"

SSHPASS_PREFIX=$(setup_sshpass)

if [ -n "${SSHPASS_PREFIX}" ]; then
    ${SSHPASS_PREFIX} ssh $SSH_OPTIONS -p${NIXPORT} ${NIXUSER}@${NIXADDR} " \
        sudo reboot now; \
    " > /dev/null || true
else
    ssh $SSH_OPTIONS -p${NIXPORT} ${NIXUSER}@${NIXADDR} " \
        sudo reboot now; \
    " > /dev/null || true
fi
