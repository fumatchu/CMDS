#!/bin/bash
# Deploy Template (linkage) for py templates
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date)
clear
cat << EOF
${GREEN}Delete Nested Port Template${TEXTRESET}

${YELLOW}
The port templates associated with this nested template does not get deleted
${TEXTRESET}

Current port templates on the system

EOF

ls /root/.meraki_mig/templates/linked/*.py | cut -c36-

echo " "
read -p "Please provide the template name you would like to delete: " DELETE_TEMPLATE
echo " "
echo ${RED}"Deleting ${DELETE_TEMPLATE}"${TEXTRESET}

rm /root/.meraki_mig/templates/linked/${DELETE_TEMPLATE}
#Duplicate nested templates for Override Use
\cp -r -f /root/.meraki_mig/templates/linked /root/.meraki_mig/templates/already_installed/
sed -i 's#/root/.meraki_mig/templates/active#/root/.meraki_mig/templates/already_installed/active#g' /root/.meraki_mig/templates/already_installed/linked/*



sleep 2
