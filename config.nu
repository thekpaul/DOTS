# `config.nu`: Main configurations
# Latest development based on Nushell Version 0.103.0

## Environment Configuration Options: `$env.config.*` #########################

### History: `$env.config.history.*` ##########################################

$env.config.history.file_format = "sqlite"
$env.config.history.isolation = false

### Completions: `$env.config.completions.*` ##################################

$env.config.completions.algorithm = "fuzzy"
$env.config.completions.sort = "smart"
$env.config.completions.case_sensitive = false

### Miscellaneous Settings ####################################################

$env.config.show_banner = true
$env.config.rm.always_trash = true
$env.config.recursion_limit = 10
$env.config.buffer_editor = (which nvim | get path | str join '')
$env.config.render_right_prompt_on_last_line = true
