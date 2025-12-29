#!/usr/bin/env bash
# Copy Nix configurations to VM

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../common/ssh-utils.sh"

# Configuration
NIXADDR="${NIXADDR:-192.168.2.130}"
NIXPORT="${NIXPORT:-22}"
NIXUSER="${NIXUSER:-eugene}"
MAKEFILE_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"

SSHPASS_PREFIX=$(setup_sshpass)

if [ -n "${SSHPASS_PREFIX}" ]; then
    rsync -av -e "${SSHPASS_PREFIX} ssh $SSH_OPTIONS -p${NIXPORT}" \
        $(get_rsync_excludes) \
        --rsync-path="sudo rsync" \
        "${MAKEFILE_DIR}/" ${NIXUSER}@${NIXADDR}:/nix-config > /dev/null
else
    rsync -av -e "ssh $SSH_OPTIONS -p${NIXPORT}" \
        $(get_rsync_excludes) \
        --rsync-path="sudo rsync" \
        "${MAKEFILE_DIR}/" ${NIXUSER}@${NIXADDR}:/nix-config > /dev/null
fi
