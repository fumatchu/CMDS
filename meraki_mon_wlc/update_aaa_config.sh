#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Update aaa new-model on WLC${TEXTRESET}
This will allow you to update the aaa new-model entry on the WLC

Enabling aaa can be unique for every environment. The script will enable aaa with the following features:

	-SSH will now be authorized from the local database on the WLC (The same username and password for the Web Administration)
	-The Console will now be authorized from the local database on the WLC (The same username and password for the Web Administration)

Technically, we will provision the following commands on the WLC:

For General AAA and SSH:

aaa new-model 
aaa authentication login default local
aaa authentication enable default enable
aaa authorization exec default local if-authenticated

For the console:
aaa authentication login CON0 local
aaa authorization exec CON0 if-authenticated
aaa authorization console
line con 0 
login authentication CON0


EOF

read -r -p "Would you like to deploy these aaa changes? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  clear
  echo ${GREEN}"Updating AAA on the WLC${TEXTRESET}"
  sleep 1
  /root/.meraki_mon_wlc/update_aaa_config.exp
fi

clear
cat <<EOF
${GREEN}Gathering new Data${TEXTRESET}
EOF
sleep 1
/root/.meraki_mon_wlc/update_config.exp
