#-------------------------------------------------------------------------------
# Programs
#-------------------------------------------------------------------------------
# Add ~/.local/bin
$env.PATH = ($env.PATH | prepend ($env.HOME | path join ".local/bin"))

# Add Homebrew bin on macOS
if ("/opt/homebrew/bin" | path exists) {
    $env.PATH = ($env.PATH | prepend "/opt/homebrew/bin")
}

# Add Nix paths
$env.PATH = ($env.PATH | prepend [
    "/run/wrappers/bin"
    "/run/current-system/sw/bin"
    "/nix/var/nix/profiles/default/bin"
    "/etc/profiles/per-user/eugene/bin"
    ($"($env.HOME)/.nix-profile/bin")
])

#-------------------------------------------------------------------------------
# SSH Agent
#-------------------------------------------------------------------------------
try {
    if ($env | get -i SSH_AUTH_SOCK) == null {
        let agent_info = (ssh-agent -c | lines | first 2 | parse "setenv {name} {value};")
        load-env {
            SSH_AUTH_SOCK: ($agent_info | where name == "SSH_AUTH_SOCK" | get value | first)
            SSH_AGENT_PID: ($agent_info | where name == "SSH_AGENT_PID" | get value | first)
        }
    }
}

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

#-------------------------------------------------------------------------------
# Vars
#-------------------------------------------------------------------------------
$env.EDITOR = "nvim"
$env.config.show_banner = false

#-------------------------------------------------------------------------------
# Startup
#-------------------------------------------------------------------------------
if $env.PWD == $env.HOME {
    try { cd /host/eugene/repos }
}
