#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Creating the AP Regsitration Summary${TEXTRESET}
sleep 2
This will allow you to see the current AP's registered to the cloud
from the perspective of the WLC
EOF

expect -f /root/.meraki_mon_wlc/sh_ap_meraki_mon_summ.exp

clear
echo ${GREEN}"These are the current status of registered AP's via WLC to the cloud${TEXTRESET}"

more /var/lib/tftpboot/wlc/ap_mon_summ

read -p "Press Enter"
