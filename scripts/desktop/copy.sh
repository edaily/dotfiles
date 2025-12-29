#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../common/ssh-utils.sh"

DESKTOPADDR="${DESKTOPADDR:-192.168.1.235}"
DESKTOPPORT="${DESKTOPPORT:-22}"
DESKTOPUSER="${DESKTOPUSER:-eugene}"
MAKEFILE_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"

rsync -av -e "ssh $SSH_OPTIONS -p${DESKTOPPORT}" \
    $(get_rsync_excludes) \
    "${MAKEFILE_DIR}/" ${DESKTOPUSER}@${DESKTOPADDR}:nix-config > /dev/null
