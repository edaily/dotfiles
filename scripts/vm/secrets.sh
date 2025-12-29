#!/usr/bin/env bash
# Copy secrets (GPG and SSH) to VM

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../common/ssh-utils.sh"

# Configuration
NIXADDR="${NIXADDR:-192.168.2.130}"
NIXPORT="${NIXPORT:-22}"
NIXUSER="${NIXUSER:-eugene}"

SSHPASS_PREFIX=$(setup_sshpass)

if [ -n "${SSHPASS_PREFIX}" ]; then
    # Copy GPG keyring
    rsync -av -e "${SSHPASS_PREFIX} ssh $SSH_OPTIONS" \
        $(get_gpg_excludes) \
        ${HOME}/.gnupg/ ${NIXUSER}@${NIXADDR}:~/.gnupg > /dev/null

    # Copy SSH keys
    rsync -av -e "${SSHPASS_PREFIX} ssh $SSH_OPTIONS" \
        $(get_ssh_excludes) \
        ${HOME}/.ssh/ ${NIXUSER}@${NIXADDR}:~/.ssh > /dev/null
else
    # Copy GPG keyring
    rsync -av -e "ssh $SSH_OPTIONS" \
        $(get_gpg_excludes) \
        ${HOME}/.gnupg/ ${NIXUSER}@${NIXADDR}:~/.gnupg > /dev/null

    # Copy SSH keys
    rsync -av -e "ssh $SSH_OPTIONS" \
        $(get_ssh_excludes) \
        ${HOME}/.ssh/ ${NIXUSER}@${NIXADDR}:~/.ssh > /dev/null
fi
