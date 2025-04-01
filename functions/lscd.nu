# Change directory and show destination contents.
#
# The `lscd` command combines the `cd` and `ls` commands to change directory
# and show its contents afterwards.
# By design, the `ls` command is executed only if `cd` is successful.
# As Nushell's built-in `cd` can handle non-path input variables,
# `lscd` tries to support all such inputs as well.
# Additionally, unlike the built-in `cd`, `lscd` is also able to primitively
# accept pipelined input to pass into the internal `cd` call.
export def --env main [
    path?: directory   # The path to change to.
    --physical (-P)    # (cd) use the physical directory structure; resolve symbolic links before processing instances of ..
    --all (-a)         # (ls) Show hidden files
    --long (-l)        # (ls) Get all available columns for each entry (slower; columns are platform-dependent)
    --short-names (-s) # (ls) Only print the file names, and not the path
    --full-paths (-f)  # (ls) display paths as absolute paths
    --du (-d)          # (ls) Display the apparent directory size ("disk usage") in place of the directory metadata size
    --mime-type (-m)   # (ls) Show mime-type in type column instead of 'file' (based on filenames only; files' contents are not examined)
    --threads (-t)     # (ls) Use multiple threads to list contents. Output will be non-deterministic.
]: [
    nothing -> table
    string -> table
] {
    if ($path != null) {
        let span = (metadata $path | get span)
        try {
            cd --physical=$physical $path
        } catch {
            let abs_path = ({ parent: $env.PWD, stem: $path } | path join)
            let msg_path = (
                if ($abs_path | str contains ' ') {
                    $"`($abs_path)`"
                } else {
                    $abs_path
                }
            )
            let messages = (
                if not ($"($abs_path)" | path exists) {
                    {
                        msg: "Directory not found"
                        txt: "directory not found"
                        help: $"($msg_path) does not exist"
                    }
                } else if not (($abs_path | path type) in ["dir" "symlink"]) {
                    {
                        msg: "Cannot change to directory"
                        txt: "is not a directory"
                        help: $"($msg_path) is not a directory"
                    }
                } else {
                    {
                        msg: "I/O error"
                        txt: "cannot read directory"
                        help: $"($msg_path) cannot be accessed"
                    }
                }
            )
            error make {
                msg: $messages.msg
                label: { text: $messages.txt, span: $span}
                help: $messages.help
            }
        }
    } else if ($in != null) {
        let path = $in
        let span = (metadata $in | get span)
        try {
            cd --physical=$physical $path
        } catch {
            let abs_path = ({ parent: $env.PWD, stem: $path } | path join)
            let msg_path = (
                if ($abs_path | str contains ' ') {
                    $"`($abs_path)`"
                } else {
                    $abs_path
                }
            )
            let messages = (
                if not ($"($abs_path)" | path exists) {
                    {
                        msg: "Directory not found"
                        txt: "directory not found"
                        help: $"($msg_path) does not exist"
                    }
                } else if not (($abs_path | path type) in ["dir" "symlink"]) {
                    {
                        msg: "Cannot change to directory"
                        txt: "is not a directory"
                        help: $"($msg_path) is not a directory"
                    }
                } else {
                    {
                        msg: "I/O error"
                        txt: "cannot read directory"
                        help: $"($msg_path) cannot be accessed"
                    }
                }
            )
            error make {
                msg: $messages.msg
                label: { text: $messages.txt, span: $span}
                help: $messages.help
            }
        }
    } else {
        cd --physical=$physical
    }

    (
        ls --all=$all --long=$long --short-names=$short_names
           --full-paths=$full_paths --du=$du --mime-type=$mime_type
           --threads=$threads
    )
}
