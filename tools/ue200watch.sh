#!/bin/bash
# Software replacement for physically replugging the UE200: if the default route interface has no
# working link for ~1 minute, re-enumerate the dongle, then bounce DHCP.
fail=0
while true; do
  GW=$(route -n get default 2>/dev/null | awk '/gateway/{print $2}')
  [ -z "$GW" ] && GW=192.168.31.2
  if ping -c1 -t2 "$GW" >/dev/null 2>&1; then
    fail=0
  else
    fail=$((fail+1))
    if [ "$fail" -ge 4 ]; then
      logger -t ue200watch "no connectivity for $((fail*15))s: re-enumerating UE200"
      /usr/local/bin/ue200reset 2>&1 | logger -t ue200watch
      sleep 8
      for i in $(networksetup -listallhardwareports | awk '/Device: en/{print $2}'); do
        ipconfig set "$i" DHCP >/dev/null 2>&1
      done
      fail=0
    fi
  fi
  sleep 15
done
