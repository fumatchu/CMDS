#!/bin/bash
#Delete Template
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date)
clear


echo "############################Collection time ${DATE}######################################"
cat << EOF
${GREEN}Deploy PreConfigured Template(s)${TEXTRESET}

This allows you to link templates together and
deploy them to the switches. you can link as menay templates
together as you need to complete the deployment



Here are the current templates:


EOF

_repeat="Y"

while [ $_repeat = "Y" ]; do
        ls /root/.meraki_mig/templates/active
        echo " "
        echo "${YELLOW}(Hint, you should be able to copy and paste the filename)"${TEXTRESET}
        read -p "Please provide the template name you would like to run: " TEMPLATE_SELECTION
        echo ${GREEN}"Adding ${TEMPLATE_SELECTION}"${TEXTRESET}
        echo python3 /root/.meraki_mig/templates/active/$TEMPLATE_SELECTION >>/root/.meraki_mig/templates/working.run

        # Prompt for repeat
        echo " "
        echo -n "Would you like to add another template to link? (Y/N)"
        read -n1 Input
        echo # Completes the line
        case $Input in
        [Nn])
                :
                _repeat="N"
                ;;
        esac
done
read -p "Press Any Key to begin deployment"
clear
echo "############################Collection time ${DATE}######################################"
echo ${GREEN}"Deploying the Script Now"${TEXTRESET}
echo "The screen may look frozen, please be patient"
sed -i "1i #!/bin/bash" "/root/.meraki_mig/templates/working.run"
chmod 700 /root/.meraki_mig/templates/working.run
unbuffer /root/.meraki_mig/templates/working.run
rm -f /root/.meraki_mig/templates/working.run
echo ${GREEN}"Script Complete!"${TEXTRESET}
sleep 2
