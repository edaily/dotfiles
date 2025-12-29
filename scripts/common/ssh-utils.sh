#!/usr/bin/env bash
# Common SSH utilities and configuration

set -euo pipefail

# SSH options used across all connections
export SSH_OPTIONS="-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o LogLevel=ERROR"

# Get password from 1Password for VM
get_vm_pass() {
    op item get zosovg44lzbzkhooy7itc43oce --reveal --format json --fields password | jq -r .value
}

# Get password from 1Password for Desktop
get_desktop_pass() {
    op item get ptqbwf7nebomg6fyrh7gycqhie --reveal --format json --fields password | jq -r .value
}

# Setup SSHPASS prefix if password is provided
setup_sshpass() {
    if [ -n "${SSHPASS:-}" ]; then
        echo "sshpass -e"
    else
        echo ""
    fi
}

# Common rsync excludes for config sync
get_rsync_excludes() {
    echo "--exclude=vendor/ --exclude=.git/ --exclude=.git-crypt/ --exclude=.jj/ --exclude=iso/"
}

# Common rsync excludes for GPG
get_gpg_excludes() {
    echo "--exclude=.#* --exclude=S.* --exclude=*.conf"
}

# Common rsync excludes for SSH
get_ssh_excludes() {
    echo "--exclude=environment"
}
