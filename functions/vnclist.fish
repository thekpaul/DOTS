function vnclist
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
  echo $VNCLIST
end
