#!/bin/bash
#Set the VTY (Line 0 4)
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Update Line VTY 0 4 for telnet output on Switches${TEXTRESET}
This will allow you to update the transport output entry on the Switches


Technically, we will provision the following commands:

For lines 0-4:
transport output all (allows switch to output telnet and ssh)


EOF

read -r -p "Would you like to deploy this change? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  clear
  echo ${GREEN}"Updating lines for telnet output${TEXTRESET}"
  sleep 1
  /root/.meraki_mon_switch/update_vty.exp
fi

clear
echo "Script complete"
sleep 1
