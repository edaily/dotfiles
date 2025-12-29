#!/usr/bin/env bash
# Reboot Desktop

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../common/ssh-utils.sh"

# Configuration
DESKTOPADDR="${DESKTOPADDR:-192.168.1.235}"
DESKTOPPORT="${DESKTOPPORT:-22}"
DESKTOPUSER="${DESKTOPUSER:-eugene}"

SSHPASS_PREFIX=$(setup_sshpass)

if [ -n "${SSHPASS_PREFIX}" ]; then
    ${SSHPASS_PREFIX} ssh $SSH_OPTIONS -p${DESKTOPPORT} ${DESKTOPUSER}@${DESKTOPADDR} " \
        sudo reboot now; \
    " > /dev/null || true
else
    ssh $SSH_OPTIONS -p${DESKTOPPORT} ${DESKTOPUSER}@${DESKTOPADDR} " \
        sudo reboot now; \
    " > /dev/null || true
fi
