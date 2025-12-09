# 90: PDK.fish
# This snippet targets the PDK server systems.

# nop for non-"pdk*" servers
if not string match -qr '^pdk[0-9]+$' (prompt_hostname)
    return
end

# Retrieve and organise pdk mount details
set -l pdkSRV # pdk remote hostnames
set -l pdkMPT # pdk local mountpoints
set -l pdkIP  # pdk remote host IP addresses

# Build list of mount details for home directories of other pdk servers
while read -l line;
    if not string match -qr '^pdk[0-9]+:/home' $line
        continue
    end

    # Fields: <host>:<dir> <mountpoint> <fstype> <options> (dump pass)
    set -l FIELDS (string split ' ' $line)

    # Disqualify if mounted fstype is not NFS
    if not string match -qr '^nfs' $FIELDS[3]
        continue
    end

    # Remote pdk server hostname, directory, mountpoint and mount options
    set -a pdkSRV (string upper (string split ':' $FIELDS[1] | read -l))
    set -a pdkMPT $FIELDS[2]
    set -a pdkIP (
        string split ',' $FIELDS[4] |
        string match --entire -r '^addr=' | string split '='
    )[-1]
end < /proc/mounts

set -l pdkCheckDir
if command -q mktemp
    set pdkCheckDir (command mktemp -d -t fish.nfsXXXXXX)
else
    if set -q TMPDIR
        set pdkCheckDir $TMPDIR/fish.nfs_check
    else
        set pdkCheckDir /tmp/fish.nfs_check
    end
    command mkdir -p $pdkCheckDir
end

# Test all pdk mountpoints (NFS) for accesibility
set -l pdkPEND # pdk mountpoint checking PIDs
set -l pdkHOME # HOME directory on pdk mountpoints being tested

for idx in (seq (count $pdkSRV))
    # Launch test in background (safe: isolated in a subshell)
    set -l target (string join '/' $pdkMPT[$idx] $USER)
    set -l command (
        string join '; and ' \
            "test -d '$target'" \
            "test -r '$target'" \
            "test -x '$target'" \
            "begin; printf '%d\n' $idx > $pdkCheckDir/$idx.txt; end"
    )
    fish --no-config -c "$command" &
    set -a pdkPEND $last_pid
    set -a pdkHOME $target
end

# Timeout watchdog for all tests, in parallel
set -l TIMEOUT 0.5
command -q sleep; and command sleep $TIMEOUT

# Collect and process results
for idx in (seq (count $pdkPEND))
    # If test is still running, NFS may be stale - kill subprocess and skip
    if kill -0 $pdkPEND[$idx] 2> /dev/null
        kill -s KILL $pdkPEND[$idx] 2> /dev/null
        if status is-interactive
            set_color red
            printf "%s access test timed out after %g seconds - skipping\n" \
                $pdkSRV[$idx] $TIMEOUT
            set_color normal
        end
        continue
    end

    if not test -f "$pdkCheckDir/$idx.txt"
        if status is-interactive
            set_color yellow
            printf "%s access test failed\n" \
                $pdkSRV[$idx] $TIMEOUT
            set_color normal
        end
        continue
    end

    # Set environment variable for pdk HOME directory on NFS
    set -gx (string join '_' $pdkSRV[$idx] 'HOME') $pdkHOME[$idx]

    # Print accessed pdk HOME directory in interactive shells
    if status is-interactive
        printf "%s directory /home mounted on %s (IP: %s), \$%s_HOME to %s\n" \
            $pdkSRV[$idx] $pdkMPT[$idx] $pdkIP[$idx] $pdkSRV[$idx] $pdkHOME[$idx]
    end
end

command rm -rf $pdkCheckDir
