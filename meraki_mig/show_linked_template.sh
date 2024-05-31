#!/bin/bash
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date)
clear

cat <<EOF

${GREEN}Show Configured Linked Template(s)${TEXTRESET}

Current templates:

EOF



ls /root/.meraki_mig/templates/linked/
echo " "

read -p "Please provide the name of the file to inspect for nested templates: " TEMPLATE
while [ -z "$TEMPLATE" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide the name of the file to inspect for nested templates: " TEMPLATE
done
cat << EOF


These are the Templates inside of this linked template:
EOF
more /root/.meraki_mig/templates/linked/${TEMPLATE} | cut -c44-

echo " "
read -p "Press Any Key"
