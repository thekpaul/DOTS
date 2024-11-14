def --env lscd [
    path?: string # TODO: @__lscd_completions
] {
    try {
        if ($path == null) {
            cd
        } else {
            cd $path
        }
    } catch {
        error make {
            msg: "Directory not found"
            label: {
                text: "directory not found"
                span: (metadata $path).span
            }
            help: $"({ parent: $env.PWD, stem: $path } | path join | path expand) does not exist"
        }
    }
    ls
}
