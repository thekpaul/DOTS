# `env.nu`: Semi-deprecated environmental configurations
# Latest development based on Nushell Version 0.103.0

## Environment Setup Functions ################################################

### Helper Commands for Environmental Awareness ###############################

# Git Directory Checking Command
def __is_git_dir [left?: string, right?: string] {
    # Determine if `git` is available in current session
    if (which git | length) == 0 {
        error make --unspanned { msg: "Git is unavailable." }
    }

    # Determine if currently within Git-controlled directory
    let repo_info = (
        ^git rev-parse --git-dir
                       --is-inside-git-dir
                       --is-bare-repository
                       --is-inside-work-tree HEAD
        | complete
    )
    if $repo_info.exit_code != 0 { return }

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

# Welcome Banner: Set a custom banner when starting a new session.
def banner [] {
    let up_str: string = (
        sys host | get uptime # Get current uptime
        | into record | transpose type num # Format into table of `type`:`num`
        | drop # Remove last entry "sign" (always +, btw)
        | each {
            if ($in.num == 1) {
                $"($in.num) ($in.type)"
            } else if ($in.num != 0) {
                $"($in.num) ($in.type)s"
            }
        } | str join ", "
    )

    print $"($up_str)...Something on Your Mind?"
}

### Left & Right Prompt Commands and Indicator Characters #####################

$env.PROMPT_COMMAND = {||
    let dir = match (do -i { $env.PWD | path relative-to $nu.home-path }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }
    let user = (whoami)
    let host = (uname | get nodename)
    let git_status = (__is_git_dir " [  " " ]")

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

$env.PROMPT_COMMAND_RIGHT = {||
    # create a right prompt in magenta with green separators and am/pm underlined
    let time_segment = ([
        (ansi reset)
        (ansi magenta)
        (date now | format date '%x %X') # try to respect user's locale
    ] | str join | str replace --regex --all "([/:])" $"(ansi green)${1}(ansi magenta)" |
        str replace --regex --all "([AP]M)" $"(ansi magenta_underline)${1}")

    $time_segment
}

$env.PROMPT_INDICATOR = "↪ "
$env.TRANSIENT_PROMPT_COMMAND = " "
$env.TRANSIENT_PROMPT_INDICATOR = "> "

# `$env.HOME` Variable for Windows Systems
# Windows systems do not have the `$env.HOME` environmental variable by default.
# As such, to replicate the `$env.HOME` found in many Unix-based systems,
# a Nushell internal variable `$nu.home-path` is used instead.
if ((uname | get kernel-name | str contains --ignore-case "windows")
    and not ('HOME' in $env)) {
    load-env { HOME: $nu.home-path }
}
