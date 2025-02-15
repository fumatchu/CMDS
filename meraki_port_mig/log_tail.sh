#!/bin/bash
#Tail for Active Log
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date "+%Y%m%d")
clear
cat <<EOF
${GREEN}Active Log${TEXTRESET}

It is suggested that you open a separate terminal to the server and run this option
EOF

while true; do
   read -p "Would you like to Continue? (y/n) " yn
   case $yn in
   [yY])
      tail -f /root/.meraki_port_mig/logs/${DATE}.log
      ;;
   [nN])
      echo exiting...
      exit
      ;;
   *) echo invalid response ;;
   esac
done
exit