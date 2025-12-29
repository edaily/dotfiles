#!/usr/bin/env bash
# Restore SSH keys and GPG keyring from backup

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MAKEFILE_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"

if [ ! -f "${MAKEFILE_DIR}/backup.tar.gz" ]; then
    echo "Error: backup.tar.gz not found in ${MAKEFILE_DIR}"
    exit 1
fi

echo "Restoring SSH keys and GPG keyring from backup..."

mkdir -p "${HOME}/.ssh" "${HOME}/.gnupg"

tar -xzvf "${MAKEFILE_DIR}/backup.tar.gz" -C "${HOME}"

chmod 700 "${HOME}/.ssh" "${HOME}/.gnupg"
chmod 600 "${HOME}/.ssh/"* 2>/dev/null || true
chmod 700 "${HOME}/.gnupg/"* 2>/dev/null || true

echo "Restore complete"
