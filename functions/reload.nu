# Reload Nushell with current or custom configurations
#
# The `reload` command combines the `clear` and `exec` commands to clear the
# current screen and execute a new Nushell session.
export def main [
    config_dir?: directory
]: [
    nothing -> nothing
] {
    let config_path = (
        if ($config_dir == null) {
            $nu.config-path
        } else {
            [ $config_dir config.nu ] | path join
        }
    )
    let env_path = (
        if ($config_dir == null) {
            $nu.env-path
        } else {
            [ $config_dir env.nu ] | path join
        }
    )
    clear; exec ($nu.current-exe) --config ($config_path) --env-config ($env_path)
}

