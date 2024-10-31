function vnclist
  argparse 'h/help' 'u/user=?' -- $argv; or return
  if set -q _flag_help
    printf '%s\n' 'vnclist - display VNC usage on current host'
    printf '%s\n' ''
    printf '%s\n' 'vnclist'
    printf '%s\n' 'vnclist -u[[=]USER]'
    printf '%s\n' ''
    printf '%s\n' 'DESCRIPTION'
    printf '%s\n' '`vnclist` is a function to display current VNC server usage on the current host.'
    printf '%s\n' 'It uses the `ps` executable to list all currently running processes,'
    printf '%s\n' 'then parses the returned process descriptions to detect display numbers and their inhabiting users.'
    printf '%s\n' ''
    printf '%s\n' '· USER is the specific user to search for.'
    printf '%s\n' ''
    printf '%s\n' 'The following options are available:'
    printf '%s\n' ''
    printf '%s\n\t%s\n' '-h or --help' 'Displays help about using this command.'
    printf '%s\n\t%s\n' '-u or --user' 'Searches and prints usage by user.'
    return 0
  end

  set -l VNCLIST
  for i in (ps -ef | grep vnc | awk ' { print $9 ":" $1 } ')
    if string match -r -- "^:.*" $i 2>&1 > /dev/null
      set -l VNCSTR (string sub -s 2 $i)
      set -l VNCPORT (string sub -e -1 (string match -r -- "^.*:" $VNCSTR))
      set -l CURCNT (count $VNCLIST)
      if count $VNCLIST > /dev/null
        for i in (seq 1 (count $VNCLIST))
          set -l CMPPORT (string sub -e -1 (string match -r -- "^.*:" $VNCLIST[$i]))
          if test $VNCPORT -le $CMPPORT
            if test $i = 1
              set -p VNCLIST $VNCSTR
            else
              set VNCLIST $VNCLIST[1..(math $i - 1)] $VNCSTR $VNCLIST[$i..$CURCNT]
            end
            break
          end
        end
        if test $CURCNT = (count $VNCLIST)
          set -a VNCLIST $VNCSTR
        end
      else
        set -a VNCLIST $VNCSTR
      end
    end
  end

  if set -q _flag_user
    set -l VNCDICT
    for i in $VNCLIST
      set i (string split ':' $i)
      if count $VNCDICT > /dev/null
        for j in (seq 1 (count $VNCDICT))
          if string match -qe -- $i[2] $VNCDICT[$j]
            set VNCDICT[$j] (string join ' ' $VNCDICT[$j] $i[1])
            break
          end
        end
        if test $j = (count $VNCDICT)
          set -a VNCDICT "$i[2] $i[1]"
        end
      else
        set -a VNCDICT "$i[2] $i[1]"
      end
    end
    if string length -q $_flag_user
      if test (string sub -e 1 $_flag_user) = '='
        set _flag_user (string sub -s 2 $_flag_user)
      end
      set PRINT_MATERIALS (string split ' ' (string match -e -- $_flag_user $VNCDICT))
      echo "User $PRINT_MATERIALS[1] at port(s) $PRINT_MATERIALS[2..]"
    else
      echo "Print-by-user mode"
      for i in (seq (count $VNCDICT))
        printf '%s' $VNCDICT[$i]
        if test $i = (count $VNCDICT)
          printf '\n'
        else
          printf ' : '
        end
      end
    end
  else
    echo $VNCLIST
  end
end
