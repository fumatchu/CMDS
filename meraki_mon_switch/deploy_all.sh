#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

echo "Deploying and Installing IOS-XE Upgrade"

clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_switch/deploy_img.sh
clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_switch/deploy.sh
