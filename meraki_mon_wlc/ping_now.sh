#!/bin/bash
#Ping Sweep Frot end to call ping_hosts
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date "+%Y%m%d")
clear
cat <<EOF
${GREEN}Ping Sweep WLC${TEXTRESET}

It is suggested that you open a separate terminal to the server and run this option
EOF

while true; do
   read -p "Would you like to Continue? (y/n) " yn
   case $yn in
   [yY])
      echo "Starting Ping Sweep"
      echo "${YELLOW}Press Ctrl+C to cancel${TEXTRESET}"
      echo "Please wait"
      sleep 1
      while true; do
         /root/.meraki_mon_wlc/ping_hosts
         sleep 5
         clear
      done
      ;;
   [nN])
      echo exiting...
      exit
      ;;
   *) echo invalid response ;;
   esac
done
exit
