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

_repeat="Y"

while [ $_repeat = "Y" ]; do
        clear
        echo ${GREEN}"Deploy PreConfigured Template(s)"${TEXTRESET}
        echo "Link port templates together and deploy them to the switches"
        echo " "
        echo "Select a Template:"
        echo " "
        ls /root/.meraki_mig/templates/active/*.py | cut -c36-
        echo " "
        echo "${YELLOW}(Hint, you should be able to copy and paste the filename)"${TEXTRESET}
        read -p "Please provide the template name you would like to run: " TEMPLATE_SELECTION
        while [ -z "$TEMPLATE_SELECTION" ]; do
                echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
                read -p "Please provide the template name you would like to run: " TEMPLATE_SELECTION
        done
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

clear

echo ${GREEN}"Save this Set of templates as a Linked Template"${TEXTRESET}
read -r -p "Would you like to save this template series collection as a linked template for future use? (y/n) " response

case "$response" in
[yY][eE][sS] | [yY])
        echo " "
        echo ${GREEN}Saving as Linked template ${TEXTRESET}
        echo " "
        echo "Since you are saving a linked template, please use a name that makes sense for the combination"
        echo "you are saving. Most Linked Templates will be re-used for whole networks."
        echo "Maybe the NetworkName_Description? -i.e. Network_Name_1_24_and_48_Port_Switches_UPLINK_EndUser_AP"
        echo "Something that makes sense to your Organization"
        echo " "
        read -p "Please provide the name you would like to use to save this linked template (no spaces): " SAVE_TEMPLATE
        while [ -z "$SAVE_TEMPLATE" ]; do
                echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
                read -p "Please provide the name you would like to use to save this linked template (no spaces): " SAVE_TEMPLATE
        done
        echo " "
        echo "Saving the template. It can be viewed under Main Menu --> Template Deployment --> Linked Templates"
        sleep 3
        cp /root/.meraki_mig/templates/working.run /root/.meraki_mig/templates/linked/${SAVE_TEMPLATE}.py
        sed -i "1i #!/bin/bash" "/root/.meraki_mig/templates/linked/${SAVE_TEMPLATE}.py"
        chmod 700 /root/.meraki_mig/templates/linked/${SAVE_TEMPLATE}.py
        #Duplicate nested templates for Override Use
        \cp -r -f /root/.meraki_mig/templates/linked /root/.meraki_mig/templates/already_installed/
        sed -i 's#/root/.meraki_mig/templates/active#/root/.meraki_mig/templates/already_installed/active#g' /root/.meraki_mig/templates/already_installed/linked/*
        ;;
*)

        echo ${RED}"Not Saving the configuration as a template"${TEXTRESET}
        ;;
esac

clear
cat <<EOF
${GREEN}These are the templates we are going to deploy:${TEXTRESET}

EOF
more /root/.meraki_mig/templates/working.run | cut -c44-

echo " "

while true; do

        read -p "Do you want to proceed? (y/n) " yn

        case $yn in
        [yY])
                echo ${GREEN}Collecting Information ${TEXTRESET}

                echo "############################Collection time ${DATE}######################################"
                echo ${GREEN}"Deploying the Script Now"${TEXTRESET}
                echo "The screen may look frozen, please be patient"
                sed -i "1i #!/bin/bash" "/root/.meraki_mig/templates/working.run"
                chmod 700 /root/.meraki_mig/templates/working.run
                unbuffer /root/.meraki_mig/templates/working.run
                rm -f /root/.meraki_mig/templates/working.run
                rm -f /root/.meraki_mig/build_port.tmp
                echo ${GREEN}"Script Complete"${TEXTRESET}
                sleep 2

                break
                ;;
        [nN])
                echo ${RED}"Cancelling Deployment"${TEXTRESET}
                rm -f /root/.meraki_mig/templates/working.run
                exit
                ;;
        *) echo invalid response ;;
        esac

done
rm -f /root/.meraki_mig/build_port.tmp
rm -f /root/.meraki_mig/templates/working.run
