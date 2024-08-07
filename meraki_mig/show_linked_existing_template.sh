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
cat << EOF


These are the Templates inside of this linked template:
EOF
more /root/.meraki_mig/templates/already_installed/linked/${TEMPLATE} | cut -c62-
echo " "
read -p "Press Enter"
