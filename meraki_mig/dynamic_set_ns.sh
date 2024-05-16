#!/bin/bash
#Change SSH User Credentials
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Command Deploy${TEXTRESET}

This will allow you deploy the command "ip name-server (ip address)"
to all the switches at once, in the IP list.
EOF

read -p "Please provide the name server in dotted decimal notion (i.e. 208.67.222.222): " NS
while [ -z "$NS" ]; do
    echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
    read -p "Please provide the name server in dotted decimal notion (i.e. 208.67.222.222): " NS
done

sed -i "/set name_ip/c\set name_ip ${NS}" /root/.meraki_mig/dynamic_set_ns.exp

cat <<EOF
${GREEN}Updating Name Server Entry ${TEXTRESET}

EOF
sleep 1

read -r -p "Would you Like to deploy this change now across the switches? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        echo "Deploying the command:"
        echo "ip name-server ${NS}"
        sleep 1
        /root/.meraki_mig/dynamic_set_ns.exp
fi
