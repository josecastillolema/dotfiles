#!/bin/sh

clean() {
  sed -r '
    s/\x1B\][0-9;]*[^\x07\x1B]*(\x07|\x1B\\)//g
    s/\x1B\[[0-9;]*[A-Za-z]//g
  '
}

UUID=$(nmcli -t -f NAME,UUID conn show | awk -F: '$1=="1 - Red Hat Global VPN"{print $2}')
STATE=$(nmcli -g GENERAL.STATE conn show "$UUID")

if [ "$STATE" = "activated" ]; then
  echo "VPN is up → disconnecting"
  nmcli conn down "$UUID"
  exit $?
fi

echo "VPN is down → connecting"

PASS=$(toolbox run pass show work/rh/vpn | clean | head -n1)
TOTP=$(toolbox run bash -lc \
  "oathtool --totp --base32 \$(pass show work/rh/oauthtool)" | clean)

printf "%s%s" "$PASS" "$TOTP" |
nmcli conn up "$UUID" --ask
