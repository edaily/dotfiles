#!/usr/bin/env bash
# Copy secrets (GPG and SSH) to Desktop

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../common/ssh-utils.sh"

# Configuration
DESKTOPADDR="${DESKTOPADDR:-192.168.1.235}"
DESKTOPPORT="${DESKTOPPORT:-22}"
DESKTOPUSER="${DESKTOPUSER:-eugene}"

SSHPASS_PREFIX=$(setup_sshpass)

if [ -n "${SSHPASS_PREFIX}" ]; then
    # Copy GPG keyring
    rsync -av -e "${SSHPASS_PREFIX} ssh $SSH_OPTIONS" \
        $(get_gpg_excludes) \
        ${HOME}/.gnupg/ ${DESKTOPUSER}@${DESKTOPADDR}:~/.gnupg > /dev/null

    # Copy SSH keys
    rsync -av -e "${SSHPASS_PREFIX} ssh $SSH_OPTIONS" \
        $(get_ssh_excludes) \
        ${HOME}/.ssh/ ${DESKTOPUSER}@${DESKTOPADDR}:~/.ssh > /dev/null
else
    # Copy GPG keyring
    rsync -av -e "ssh $SSH_OPTIONS" \
        $(get_gpg_excludes) \
        ${HOME}/.gnupg/ ${DESKTOPUSER}@${DESKTOPADDR}:~/.gnupg > /dev/null

    # Copy SSH keys
    rsync -av -e "ssh $SSH_OPTIONS" \
        $(get_ssh_excludes) \
        ${HOME}/.ssh/ ${DESKTOPUSER}@${DESKTOPADDR}:~/.ssh > /dev/null
fi
