#!/bin/bash
#Collect hostnames and match to Serial
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date)
clear

cat <<EOF
${GREEN}Hostname Migration${TEXTRESET}

EOF

# Set the input file name here
INPUT="/root/.meraki_port_mig/ip_list"
clear
echo "############################Collection time ${DATE}######################################"
cat <<EOF
${YELLOW}Migrating Hostnames${TEXTRESET}

EOF

# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo "$IP"


# Define the input file
input_file="/root/.meraki_port_mig/serial/${IP}"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
  echo "File $input_file not found."
  exit 1
fi

# Count the number of lines in the file
line_count=$(wc -l < "$input_file")

# Conditional statement to check the line count
if [ "$line_count" -gt 1 ]; then
  echo "The file ${IP} has more than one line, it's a stack"
  sed -i '/^IP=/c\IP=' /root/.meraki_port_mig/convert_hostname_stack.sh
  sed -i "s/IP=/IP=${IP}/g" /root/.meraki_port_mig/convert_hostname_stack.sh
  /root/.meraki_port_mig/convert_hostname_stack.sh
else
  echo "The file ${IP} has one line it's a single switch."
  sed -i '/^IP=/c\IP=' /root/.meraki_port_mig/convert_hostname_single.sh
  sed -i "s/IP=/IP=${IP}/g" /root/.meraki_port_mig/convert_hostname_single.sh
  /root/.meraki_port_mig/convert_hostname_single.sh
fi


done <"$INPUT"