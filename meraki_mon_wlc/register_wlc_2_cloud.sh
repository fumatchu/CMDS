#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Register WLC to Cloud${TEXTRESET}
This will register the WLC to the Cloud

EOF

read -p "Press Enter"

/root/.meraki_mon_wlc/register_wlc_2_cloud.exp

clear

cat <<EOF
${YELLOW}Waiting for WLC Registration${TEXTRESET}
EOF

echo "Please Wait..."
i=60;while [ $i -gt 0 ];do if [ $i -gt 9 ];then printf "\b\b$i";else  printf "\b\b $i";fi;sleep 1;i=`expr $i - 1`;done
clear
/root/.meraki_mon_wlc/register_wlc_2_cloud_check.exp

clear

cat <<EOF
${GREEN}Current status of WLC Registration${TEXTRESET}
EOF
more /var/lib/tftpboot/wlc/sh-meraki-connect

read -p "Press Enter"
