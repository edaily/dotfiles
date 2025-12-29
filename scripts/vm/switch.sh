#!/usr/bin/env bash
# Run nixos-rebuild switch on VM

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../common/ssh-utils.sh"

# Configuration
NIXADDR="${NIXADDR:-192.168.2.130}"
NIXPORT="${NIXPORT:-22}"
NIXUSER="${NIXUSER:-eugene}"
NIXNAME="${NIXNAME:-vm-aarch64}"

SSHPASS_PREFIX=$(setup_sshpass)

if [ -n "${SSHPASS_PREFIX}" ]; then
    ${SSHPASS_PREFIX} ssh $SSH_OPTIONS -p${NIXPORT} ${NIXUSER}@${NIXADDR} " \
        sudo NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild switch --flake \"/nix-config#${NIXNAME}\" \
    " > /dev/null
else
    ssh $SSH_OPTIONS -p${NIXPORT} ${NIXUSER}@${NIXADDR} " \
        sudo NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild switch --flake \"/nix-config#${NIXNAME}\" \
    " > /dev/null
fi
