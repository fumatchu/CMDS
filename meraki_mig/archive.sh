#!/bin/bash
#Change SSH User Credentials
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date)
clear
cat <<EOF
${GREEN}Archive Logs Files${TEXTRESET}

This will archive all logs to an acrhive folder in the logs directory
EOF

read -r -p "Would you Like to archive all the current logs? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        echo "Archiving the logs files"
        mkdir /root/.meraki_mig/logs/"archive-logs-${DATE}"
        mv -v /root/.meraki_mig/logs/*.log /root/.meraki_mig/logs/"archive-logs-${DATE}"/
        \cp -R /root/.meraki_mig/logs/"archive-logs-${DATE}"/ /root
        sleep 1

fi
