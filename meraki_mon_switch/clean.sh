#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Gather WLC Baseline${TEXTRESET}

The Server will now login via ssh to the WLC. 
Please make sure you have SSH enabled.
 
This can be accomplished by providing the basic AAA information to the WLC:

aaa new-model 
aaa authentication login default local
aaa authentication enable default enable
aaa authorization exec default local if-authenticated

Please make sure you have minimally setup access for SSH first, before continuing


EOF

read -r -p "Is the WLC enabled for SSH login? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  echo "Logging in and analyzing WLC"
  /root/.meraki_mon_wlc/clean.exp
else
  echo "${RED}Cancelling${TEXTRESET}"
fi

sleep 1

clear
