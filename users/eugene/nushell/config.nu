#-------------------------------------------------------------------------------
# SSH Agent
#-------------------------------------------------------------------------------
# Nushell doesn't have a direct equivalent to `ssh-agent -c` in the same way,
# but we can try to handle it. For now, we'll assume a simpler approach or
# rely on system-level agents if possible.
# A basic implementation:
if ($env | get -i SSH_AUTH_SOCK) == null {
    let agent_info = (ssh-agent -c | lines | first 2 | parse "setenv {name} {value};")
    load-env {
        SSH_AUTH_SOCK: ($agent_info | where name == "SSH_AUTH_SOCK" | get value | first)
        SSH_AGENT_PID: ($agent_info | where name == "SSH_AGENT_PID" | get value | first)
    }
}

#-------------------------------------------------------------------------------
# Programs
#-------------------------------------------------------------------------------
# Add ~/.local/bin
$env.PATH = ($env.PATH | prepend ($env.HOME | path join ".local/bin"))

#-------------------------------------------------------------------------------
# Prompt
#-------------------------------------------------------------------------------
$env.PROMPT_COMMAND = {|| create_left_prompt }

def create_left_prompt [] {
    let dir = (
        if ($env.PWD | path split | zip ($env.HOME | path split) | all { $in.0 == $in.1 }) {
            ($env.PWD | str replace $env.HOME "~")
        } else {
            $env.PWD
        }
    )
    let path_color = (if (is-admin) { "red" } else { "green" })
    let separator_color = (if (is-admin) { "light_red" } else { "light_green" })
    let path_segment = $"($dir)"

    $path_segment
}


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
