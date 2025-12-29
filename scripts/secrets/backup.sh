#!/usr/bin/env bash
# Backup SSH keys and GPG keyring

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MAKEFILE_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"

echo "Backing up SSH keys and GPG keyring..."

tar -czvf "${MAKEFILE_DIR}/backup.tar.gz" \
    -C "${HOME}" \
    --exclude='.gnupg/.#*' \
    --exclude='.gnupg/S.*' \
    --exclude='.gnupg/*.conf' \
    --exclude='.ssh/environment' \
    .ssh/ \
    .gnupg

echo "Backup created at ${MAKEFILE_DIR}/backup.tar.gz"
