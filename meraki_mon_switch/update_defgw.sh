#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Update Gateway of Last Resort on Switches${TEXTRESET}
This will allow you to update Default Gateway entry on the Switches

Enabling a Gateway of last resort should be implemented by subnet.

Please make sure that all the switches you have in the current batch
are in the same subnet and would use the same upstream ip address for access 

Catalyst monitoring needs a routable GW of last resort above and beyond the command
"ip default-gateway"


Technically, we will provision the following commands:

ip route 0.0.0.0 0.0.0.0 <<def_gw_that you provide>>



EOF

read -r -p "Would you like to proceed? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  clear
  /root/.meraki_mon_switch/update_ipgw.sh
fi
