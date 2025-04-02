# 90: PDK.fish
# This snippet targets the PDK server systems.

if string match -qr 'pdk*' (prompt_hostname)
  for i in (mount | grep pdk)
    if string match -qr -- '^pdk[0-9]' $i
      set -l mount_args (echo $i | awk ' { print $1 } ' | string split ":")
      set -l PDK (string upper $mount_args[1])
      set -l mount_dir $mount_args[2]
      set -l mount_point (echo $i | awk ' { print $3 } ')
      set -l ip_addr (echo $i | awk ' { print $NF } ' | grep -E -o ',addr=(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)' | string sub -s 7)
      if test -d $mount_point/$USER; and test -x $mount_point/$USER
        if status --is-interactive
          echo $PDK directory $mount_dir mounted on $mount_point \(IP: $ip_addr\)
        end
        set -g (string join '' $PDK "_HOME") $mount_point/$USER
      end
    end
  end
end
