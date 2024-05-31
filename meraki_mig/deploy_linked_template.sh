#!/bin/bash
# Deploy Template (linkage) for py templates
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date)

#Generating 24 and 48 port Serial Numbers
cat /var/lib/tftpboot/*-shmr >/root/.meraki_mig/build_port.tmp
rm -f /root/.meraki_mig/switch_serials_24.txt
rm -f /root/.meraki_mig/switch_serials_48.txt
cat /root/.meraki_mig/build_port.tmp | grep C9300-48 | grep -E -o "Q.{0,13}" >/root/.meraki_mig/switch_serials_48.txt
cat /root/.meraki_mig/build_port.tmp | grep C9300-24 | grep -E -o "Q.{0,13}" >/root/.meraki_mig/switch_serials_24.txt

clear

echo "############################Collection time ${DATE}######################################"

cat <<EOF
${GREEN}Deploy PreConfigured Template(s)${TEXTRESET}
Deploy a Linked (Nested) Template
Select a Template:

EOF
ls /root/.meraki_mig/templates/linked
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

more /root/.meraki_mig/templates/linked/${TEMPLATE_SELECTION} | cut -c44-

echo " "
read -r -p "Would you like to deploy the selected template? (y/n) " response

case "$response" in
[yY][eE][sS] | [yY])
        echo " "
        echo ${GREEN}Deploying Template ${TEMPLATE_SELECTION} ${TEXTRESET}
        echo " "
        sleep 3
        unbuffer /root/.meraki_mig/templates/linked/${TEMPLATE_SELECTION}
        echo ${GREEN}Script Complete${TEXTRESET}
        ;;
*)

        echo ${RED}"Cancelling Deployment"${TEXTRESET}
        sleep 2
        ;;
esac
