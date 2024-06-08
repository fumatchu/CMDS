#!/bin/bash
#Advanced Template Creation Script
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date)
clear

cat /var/lib/tftpboot/*-shmr >/root/.meraki_mig/build_port.tmp
rm -f /root/.meraki_mig/switch_serials_24.txt
rm -f /root/.meraki_mig/switch_serials_48.txt
cat /root/.meraki_mig/build_port.tmp | grep C9300-48 | grep -E -o "Q.{0,13}" >/root/.meraki_mig/switch_serials_48.txt
cat /root/.meraki_mig/build_port.tmp | grep C9300-24 | grep -E -o "Q.{0,13}" >/root/.meraki_mig/switch_serials_24.txt

cat <<EOF
${GREEN}Port Template Creation${TEXTRESET}

This will allow you to create port conifgurations for 24 or 48 port downlinks.
Once you have created these templates, you will be allowed to link them together under
Main Menu -->Advanced Template Deployment --> Deploy a template
Here, you will make the template of a type, meaning, for example, the following:
All AP's on port 40-48 for a 48 port switch, or ports 20-24 for a 24 port switch.
Then, all end user ports (access vlan and voice vlan) for ports 1-10, etc.
You create templates for each need, then with the Deploy a Template Option, you can select
the templates you want, linked together, for a 24 or 48 port switch to have all ports be configured.

EOF
read -p "Press Any Key when Ready"

clear

read -p "Is this a 24 port switch or a 48 port switch template? (Please specify 24 or 48): " SWITCH_DENSITY
while [ -z "$SWITCH_DENSITY" ]; do
    echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
    read -p "Is this a 24 port switch or a 48 port switch template? (Please specify 24 or 48): " SWITCH_DENSITY
done
while ! [ $SWITCH_DENSITY -eq 24 -o $SWITCH_DENSITY -eq 48 ]; do
    echo ${RED}"The field must be 24 or 48 ports.. Please try again${TEXTRESET}"
    read -p "Is this a 24 port switch or a 48 port switch template? (Please specify 24 or 48): " SWITCH_DENSITY
done

read -p "Please specify the first physical port in the range modify: " FP
while [ -z "$FP" ]; do
    echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
    read -p "Please specify the first physical port in the range modify: " FP
done
while [ $SWITCH_DENSITY -eq 24 -a $FP -gt 24 -o $SWITCH_DENSITY -eq 48 -a $FP -gt 48 ]; do
    echo ${RED}"The first port number you provided exceeds the density of the switch. This program only supports downlink ports${TEXTRESET}"
    read -p "Please provide the first physical port in the range to modify: " FP
done

read -p "Please provide the last physical port in the range to modify: " LP
while [ -z "$LP" ]; do
    echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
    read -p "Please provide the last physical port in the range to modify: " LP
done
while [ $SWITCH_DENSITY -eq 24 -a $LP -gt 24 -o $SWITCH_DENSITY -eq 48 -a $LP -gt 48 ]; do
    echo ${RED}"The last port number you provided exceeds the density of the switch. This program only supports downlink ports${TEXTRESET}"
    read -p "Please provide the last physical port in the range to modify: " LP
done

read -p "Please provide the switch port type (access or trunk): " SWITCH_TYPE
while [ -z "$SWITCH_TYPE" ]; do
    echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
    read -p "Please provide the switch port type (access or trunk): " SWITCH_TYPE
done
while ! [ "$SWITCH_TYPE" = "access" -o "$SWITCH_TYPE" = "trunk" ]; do
    echo ${RED}"This field must be access or trunk.. Please try again${TEXTRESET}"
    read -p "Please provide the switch port type (access or trunk): " SWITCH_TYPE
done

#Is this access or Trunk?
if [ "$SWITCH_TYPE" = "access" ]; then
    echo " "
    echo "${GREEN}Access Port Configuration${TEXTRESET}"
    read -p "Please provide the access vlan to use: " ACCESS_VLAN
    while [ -z "$ACCESS_VLAN" ]; do
        echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
        read -p "Please provide the access vlan to use: " ACCESS_VLAN
    done
    read -p "Please provide the voice vlan to use: " VOICE_VLAN
    while [ -z "$VOICE_VLAN" ]; do
        echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
        read -p "Please provide the voice vlan to use: " VOICE_VLAN
    done
    read -p "Please provide the description of the port (Please do not use special characters or spaces): " DESCRIPTION
    while [ -z "$DESCRIPTION" ]; do
        echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
        read -p "Please provide the description of the port (Please do not use special characters or spaces): " DESCRIPTION
    done
else
    echo " "
    echo ${GREEN}"Trunk port configuration${TEXTRESET}"

    read -p "Please provide the native vlan for the trunk: " NATIVE_VLAN
    while [ -z "$NATIVE_VLAN" ]; do
        echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
        read -p "Please provide the native vlan for the trunk: " NATIVE_VLAN
    done
    read -p "Please provide the allowed VLANs for the trunk (i.e. 2,3,4 or 1-1000 or 2,3,4,10-50): " ALLOWED_VLAN
    while [ -z "$ALLOWED_VLAN" ]; do
        echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
        read -p "Please provide the allowed VLANs for the trunk (i.e. 2,3,4 or 1-1000 or 2,3,4,10-50): " ALLOWED_VLAN
    done

    read -p "Please provide the description for the port (Please do not use special characters or spaces): " DESCRIPTION
    while [ -z "$DESCRIPTION" ]; do
        echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
        read -p "Please provide the description for the port (Please do not use special characters or spaces): " DESCRIPTION
    done
fi

#Which template do we use?

if [ "$SWITCH_DENSITY" = "24" -a "$SWITCH_TYPE" = "access" ]; then
    echo ${GREEN}"Using 24 port template with access${TEXTRESET}"
    \cp /root/.meraki_mig/templates/modify_access.py.template /root/.meraki_mig/templates/working.template
    sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_mig/templates/working.template
    sed -i '5 r /root/.meraki_mig/api_key.key' /root/.meraki_mig/templates/working.template
    sed -i "s/NEW_VLAN =/NEW_VLAN = ${ACCESS_VLAN}/" /root/.meraki_mig/templates/working.template
    sed -i "s/NEW_VOICE_VLAN =/NEW_VOICE_VLAN = ${VOICE_VLAN}/" /root/.meraki_mig/templates/working.template
    echo NAME = "\"${DESCRIPTION}\"" >/root/.meraki_mig/templates/name.tmp
    sed -i '15 r /root/.meraki_mig/templates/name.tmp' /root/.meraki_mig/templates/working.template
    echo 'SERIAL_FILE = "/root/.meraki_mig/switch_serials_24.txt"' >/root/.meraki_mig/templates/config.tmp
    sed -i '9 r /root/.meraki_mig/templates/config.tmp' /root/.meraki_mig/templates/working.template
    ((LP = LP + 1))
    sed -i "s/LP =/LP = $LP/" /root/.meraki_mig/templates/working.template
    sed -i "s/FP =/FP = ${FP}/" /root/.meraki_mig/templates/working.template
else
    echo " "
fi

if [ "$SWITCH_DENSITY" = "24" -a "$SWITCH_TYPE" = "trunk" ]; then
    echo ${GREEN}"Using 24 port template with trunk${TEXTRESET}"
    \cp /root/.meraki_mig/templates/modify_trunk.py.template /root/.meraki_mig/templates/working.template
    sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_mig/templates/working.template
    sed -i '5 r /root/.meraki_mig/api_key.key' /root/.meraki_mig/templates/working.template
    sed -i "s/NEW_VLAN =/NEW_VLAN = ${NATIVE_VLAN}/" /root/.meraki_mig/templates/working.template
    echo NAME = "\"${DESCRIPTION}\"" >/root/.meraki_mig/templates/name.tmp
    sed -i '15 r /root/.meraki_mig/templates/name.tmp' /root/.meraki_mig/templates/working.template
    echo ALLOWED_VLANS = "\"${ALLOWED_VLAN}\"" >/root/.meraki_mig/templates/name.tmp
    sed -i '15 r /root/.meraki_mig/templates/name.tmp' /root/.meraki_mig/templates/working.template
    echo 'SERIAL_FILE = "/root/.meraki_mig/switch_serials_24.txt"' >/root/.meraki_mig/templates/config.tmp
    sed -i '9 r /root/.meraki_mig/templates/config.tmp' /root/.meraki_mig/templates/working.template
    ((LP = LP + 1))
    sed -i "s/LP =/LP = $LP/" /root/.meraki_mig/templates/working.template
    sed -i "s/FP =/FP = ${FP}/" /root/.meraki_mig/templates/working.template

else
    echo " "
fi

if [ "$SWITCH_DENSITY" = "48" -a "$SWITCH_TYPE" = "access" ]; then
    echo ${GREEN}"Using 48 port template with access${TEXTRESET}"
    \cp /root/.meraki_mig/templates/modify_access.py.template /root/.meraki_mig/templates/working.template
    sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_mig/templates/working.template
    sed -i '5 r /root/.meraki_mig/api_key.key' /root/.meraki_mig/templates/working.template
    sed -i "s/NEW_VLAN =/NEW_VLAN = ${ACCESS_VLAN}/" /root/.meraki_mig/templates/working.template
    sed -i "s/NEW_VOICE_VLAN =/NEW_VOICE_VLAN = ${VOICE_VLAN}/" /root/.meraki_mig/templates/working.template
    echo NAME = "\"${DESCRIPTION}\"" >/root/.meraki_mig/templates/name.tmp
    sed -i '15 r /root/.meraki_mig/templates/name.tmp' /root/.meraki_mig/templates/working.template
    echo 'SERIAL_FILE = "/root/.meraki_mig/switch_serials_48.txt"' >/root/.meraki_mig/templates/config.tmp
    sed -i '9 r /root/.meraki_mig/templates/config.tmp' /root/.meraki_mig/templates/working.template
    ((LP = LP + 1))
    sed -i "s/LP =/LP = $LP/" /root/.meraki_mig/templates/working.template
    sed -i "s/FP =/FP = ${FP}/" /root/.meraki_mig/templates/working.template

else
    echo " "
fi

if [ "$SWITCH_DENSITY" = "48" -a "$SWITCH_TYPE" = "trunk" ]; then
    echo ${GREEN}"Using 48 port template with trunk${TEXTRESET}"
    \cp /root/.meraki_mig/templates/modify_trunk.py.template /root/.meraki_mig/templates/working.template
    sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_mig/templates/working.template
    sed -i '5 r /root/.meraki_mig/api_key.key' /root/.meraki_mig/templates/working.template
    sed -i "s/NEW_VLAN =/NEW_VLAN = ${NATIVE_VLAN}/" /root/.meraki_mig/templates/working.template
    echo NAME = "\"${DESCRIPTION}\"" >/root/.meraki_mig/templates/name.tmp
    sed -i '15 r /root/.meraki_mig/templates/name.tmp' /root/.meraki_mig/templates/working.template
    echo ALLOWED_VLANS = "\"${ALLOWED_VLAN}\"" >/root/.meraki_mig/templates/name.tmp
    sed -i '15 r /root/.meraki_mig/templates/name.tmp' /root/.meraki_mig/templates/working.template
    echo 'SERIAL_FILE = "/root/.meraki_mig/switch_serials_48.txt"' >/root/.meraki_mig/templates/config.tmp
    sed -i '9 r /root/.meraki_mig/templates/config.tmp' /root/.meraki_mig/templates/working.template
    ((LP = LP + 1))
    sed -i "s/LP =/LP = $LP/" /root/.meraki_mig/templates/working.template
    sed -i "s/FP =/FP = ${FP}/" /root/.meraki_mig/templates/working.template
else
    echo " "
fi

((LP = LP - 1))

cat <<EOF

EOF

cat <<EOF
You must save this template with a name
A suggestion might be:
${DESCRIPTION}_${SWITCH_DENSITY}PORT_SW_${SWITCH_TYPE}_FIRSTPORT_${FP}_LASTPORT_${LP}


Something that makes sense to your organization, but is descriptive

EOF


read -p "Please provide a name for this template (no spaces): " TEMPLATE_NAME
while [ -z "$TEMPLATE_NAME" ]; do
    echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
    read -p "Please provide a name for this template (no speaces): " TEMPLATE_NAME
done
echo ${GREEN}"Saving Template"${TEXTRESET}
sleep 2

\cp /root/.meraki_mig/templates/working.template /root/.meraki_mig/templates/active/$TEMPLATE_NAME.py

#Duplicate the template for Override Use
\cp -r -f /root/.meraki_mig/templates/active /root/.meraki_mig/templates/already_installed/
sed -i 's#/root/.meraki_mig/switch_serials_24.txt#/root/.meraki_mig/templates/already_installed/switch_serials_24.txt#g' /root/.meraki_mig/templates/already_installed/active/*
sed -i 's#/root/.meraki_mig/switch_serials_48.txt#/root/.meraki_mig/templates/already_installed/switch_serials_48.txt#g' /root/.meraki_mig/templates/already_installed/active/*



rm -f /root/.meraki_mig/templates/working.template
rm -f /root/.meraki_mig/templates/name.tmp
rm -f /root/.meraki_mig/templates/config.tmp
rm -f /root/.meraki_mig/build_port.tmp
