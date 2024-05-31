#!/bin/bash
# Deploy Template (linkage) for py templates
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date)
clear
cat << EOF
${GREEN}Delete Port Template(s)${TEXTRESET}

${YELLOW}
If you have created nested templates, please make sure
port template you are deleting does not affect them
${TEXTRESET}

Current port templates on the system

EOF

ls /root/.meraki_mig/templates/active/*.py | cut -c36-

echo " "
read -p "Please provide the template name you would like to delete: " DELETE_TEMPLATE
echo " "
echo ${RED}"Deleting ${DELETE_TEMPLATE}"${TEXTRESET}
rm /root/.meraki_mig/templates/active/${DELETE_TEMPLATE}

#Duplicate the template for Override Use
\cp -r -f /root/.meraki_mig/templates/active /root/.meraki_mig/templates/already_installed/
sed -i 's#/root/.meraki_mig/switch_serials_24.txt#/root/.meraki_mig/templates/already_installed/switch_serials_24.txt#g' /root/.meraki_mig/templates/already_installed/active/*
sed -i 's#/root/.meraki_mig/switch_serials_48.txt#/root/.meraki_mig/templates/already_installed/switch_serials_48.txt#g' /root/.meraki_mig/templates/already_installed/active/*

sleep 2
