#! /usr/bin/env bash

if [[ -z "$(ip addr show | grep '00:15:5d:e9:b0:7a')" ]]; then
  sudo ip link add vmnic0 type dummy
  sudo ip link set vmnic0 addr 00:15:5d:e9:b0:7a
fi

# NOTE: `cron` is used on systems with `systemd`, and as this script uses
#       `sudo`, add the following line after `sudo crontab -e` in command line:
#
#         @reboot /path/to/this/script/sigasi_ip.sh
