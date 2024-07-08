#!/bin/bash
#Setup Wizard
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
SERVER_IP=$(hostname -I)
INPUT="/root/.meraki_mon_wlc/ip_list"
clear
cat <<EOF
${GREEN}Enable AVC/Telemtry${TEXTRESET}
This script will validate that you have the correct license level and enable AVC/Telemetry for you

${RED}This script WILL BE disruptive to clients as it needs to shutdown wireless profiles for a successful AVC enablement
APs must REJOIN (Not reboot) to the WLC after the profile update${TEXTRESET}
EOF

read -r -p "Would you like to continue? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    clear

    /root/.meraki_mon_wlc/check_license_level.sh

    /root/.meraki_mon_wlc/update_config.exp

    /root/.meraki_mon_wlc/update_wireles_policy.sh
fi

echo "script complete"
sleep 2
