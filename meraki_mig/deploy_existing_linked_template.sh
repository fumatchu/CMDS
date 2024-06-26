#!/bin/bash
# Deploy Template (linkage) for py templates
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date)
clear

echo "############################Collection time ${DATE}######################################"

cat <<EOF
${GREEN}Deploy PreConfigured Template(s)${TEXTRESET}
Deploy a Linked (Nested) Template
Select a Template:

EOF
ls /root/.meraki_mig/templates/already_installed/linked
echo " "

read -p "Please provide the template name you would like to run: " TEMPLATE_SELECTION
while [ -z "$TEMPLATE_SELECTION" ]; do
        echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
        read -p "Please provide the template name you would like to run: " TEMPLATE_SELECTION
done
echo ${GREEN}"Adding ${TEMPLATE_SELECTION}"${TEXTRESET}
sleep 1

cat <<EOF
Based on your selection, this is the contents of this nested template:

EOF

more /root/.meraki_mig/templates/already_installed/linked/${TEMPLATE_SELECTION} | cut -c62-

echo " "
read -r -p "Would you like to deploy the selected template? (y/n) " response

case "$response" in
[yY][eE][sS] | [yY])
        echo " "
        echo ${GREEN}Deploying Template ${TEMPLATE_SELECTION} ${TEXTRESET}
        echo " "
        sleep 3
        unbuffer /root/.meraki_mig/templates/already_installed/linked/${TEMPLATE_SELECTION}
        echo ${GREEN}Script Complete${TEXTRESET}
        ;;
*)

        echo ${RED}"Cancelling Deployment"${TEXTRESET}
        sleep 2
        ;;
esac
