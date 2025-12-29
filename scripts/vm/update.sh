#!/usr/bin/env bash
# Full VM update workflow: copy, switch, reboot

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../common/ssh-utils.sh"

echo "copying into vm..."
"${SCRIPT_DIR}/copy.sh"

echo "switching..."
"${SCRIPT_DIR}/switch.sh"

echo "rebooting..."
"${SCRIPT_DIR}/reboot.sh"

echo "VM update complete"
