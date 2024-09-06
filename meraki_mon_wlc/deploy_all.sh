#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

echo "Deploying and Installing IOS-XE Upgrade"
echo "The total timtimated time  to upgrade and install/reboot IOS-XE is:"
/root/.meraki_mon_wlc/time.sh
cat << EOF

Deployment will start shortly
EOF
sleep 4

clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_wlc/deploy_img.sh
clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_wlc/deploy.exp
