function fish_greeting
# uptime -p >/dev/null 2>&1 # Flush any possible error messages
  if uptime -p >/dev/null 2>&1
    # Supported on most Linux distros, returns uptime duration only
    # when the machine is up for less than '0' minutes then
    # 'uptime -p' returns ONLY 'up', so we need to set a default value
    set UP (uptime -p | awk -F 'up ' '{print $2}')
  else
    # Supports Mac OS X, Debian 7, etc, returns entire uptime status
    set UP (uptime | sed -E 's/^[^,]*up *//; s/mins/minutes/; s/hrs?/hours/;
    s/([[:digit:]]+):0?([[:digit:]]+)/\1 hours, \2 minutes/; s/^1 hours/1 hour/;
    s/ 1 hours/ 1 hour/; s/min,/minutes,/; s/ 0 minutes,/ less than a minute,/;
    s/ 1 minutes/ 1 minute/; s/  / /; s/, *[[:digit:]]* users?.*//')
  end

  echo "$UP...Something on Your Mind?"
end
