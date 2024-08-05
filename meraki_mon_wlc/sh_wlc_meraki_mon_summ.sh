#!/bin/bash
#Get Monitoring status from WLC
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Creating the AP Regsitration Summary${TEXTRESET}
sleep 2
This will allow you to see the current WLC registration to the cloud
from the WLC's perspective
EOF

expect -f /root/.meraki_mon_wlc/sh_wlc_meraki_mon_summ.exp

clear
echo ${GREEN}"This is the WLC's current resgistration status${TEXTRESET}"

more /var/lib/tftpboot/wlc/wlc_mon_summ

read -p "Press Enter"
