# Auto-generated from Nushell Version 0.99.1

### Helper Commands for Environmental Awareness ###############################

# Git Directory Checking Command
def __is_git_dir [left?: string, right?: string] {
    # Determine if `git` is available in current session
    if (which git | length) == 0 {
        error make --unspanned { msg: "Git is unavailable." }
    }

    let repo_info = (
        ^git rev-parse --git-dir
                       --is-inside-git-dir
                       --is-bare-repository
                       --is-inside-work-tree HEAD
        | complete
    )

    if $repo_info.exit_code != 0 {
        return null
    }

#   let repo_opts = ($repo_info.stdout | split row (char newline) | first 5)
    # Order of data storage
    # -> "git_dir", "inside_gitdir", "bare_repo", "inside_worktree", "sha"

    let branch_segment = $"(^git rev-parse --abbrev-ref HEAD)"
    let commit_segment = $"(^git rev-parse --short HEAD)"
    let repo_stat = $"($branch_segment) at ($commit_segment)"

    # Formatting output

    if ($left | is-empty) {
        $repo_stat
    } else if ($right | is-empty) {
        $"($left)($repo_stat)($left)"
    } else {
        $"($left)($repo_stat)($right)"
    }
}

# Status Checking Command
def __last_status [] {
    if ($env.LAST_EXIT_CODE != 0) {
        $"(ansi rb)  ($env.LAST_EXIT_CODE)(ansi reset)"
    } else {
        $"(ansi g)  (ansi reset)"
    }
}

def create_left_prompt [] {
    let dir = match (do --ignore-shell-errors { $env.PWD | path relative-to $nu.home-path }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }
    let user = (whoami)
    let host = (uname | get nodename)
    let git_status = try { __is_git_dir " [  " " ]" } catch { "" }

    let user_color = (if (is-admin) { ansi light_red_bold } else { ansi light_blue_bold })
    let host_color = (ansi light_purple_bold)
    let path_color = (ansi green_bold)
    let git_color = (ansi dark_gray)

    let user_segment = $"($user_color)($user)(ansi reset)"
    let host_segment = $"($host_color)($host)(ansi reset)"
    let path_segment = $"($path_color)  ($dir)(ansi reset)"
    let git_segment = $"($git_color)($git_status)(ansi reset)"

    let last_exit_code = (__last_status)

    $"($user_segment) at ($host_segment) ($path_segment) ($git_segment) (__last_status)\n "
}

def create_right_prompt [] {
    # create a right prompt in magenta with green separators and am/pm underlined
    let time_segment = ([
        (ansi reset)
        (ansi magenta)
        (date now | format date '%x %X') # try to respect user's locale
    ] | str join | str replace --regex --all "([/:])" $"(ansi green)${1}(ansi magenta)" |
        str replace --regex --all "([AP]M)" $"(ansi magenta_underline)${1}")

    $time_segment
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = {|| create_left_prompt }
# FIXME: This default is not implemented in rust code as of 2023-09-08.
$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "↪ " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

### Transient Prompt ##########################################################
# Use a TRANSIENT PROMPT for past commands.                                   #
###############################################################################
$env.TRANSIENT_PROMPT_COMMAND = {|| " "}
$env.TRANSIENT_PROMPT_INDICATOR = {|| "> " }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
# $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| "" }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
    ($nu.data-dir | path join 'completions') # default home for nushell completions
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# An alternate way to add entries to $env.PATH is to use the custom command `path add`
# which is built into the nushell stdlib:
# use std "path add"
# $env.PATH = ($env.PATH | split row (char esep))
# path add /some/path
# path add ($env.CARGO_HOME | path join "bin")
# path add ($env.HOME | path join ".local" "bin")
# $env.PATH = ($env.PATH | uniq)

# To load from a custom file you can use:
# source ($nu.default-config-dir | path join 'custom.nu')

### Editor Configuration ######################################################
# If Neovim exists, use the first absolute path available.                    #
# If not, the field will remain empty.                                        #
###############################################################################
$env.EDITOR = (do --ignore-shell-errors { which nvim | get path | get 0 })
