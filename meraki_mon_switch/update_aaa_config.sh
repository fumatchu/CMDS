#!/bin/bash
#Set the aaa
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Update aaa new-model on Switches${TEXTRESET}
This will allow you to update the aaa new-model entry on the Switches

Enabling aaa can be unique for every environment. The script will enable aaa with the following features:

	-SSH will now be authorized from the local database on the Switches
	-The Console will now be authorized from the local database of the switches

Technically, we will provision the following commands:

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

read -r -p "Would you like to deploy these changes to all switches now? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  clear
  echo ${GREEN}"Updating AAA${TEXTRESET}"
  sleep 1
  /root/.meraki_mon_switch/update_aaa_config.exp
fi
echo ${GREEN}"Script Complete"${TEXTRESET}
sleep 2
