#!/bin/bash
#Collect hostnames and match to Serial
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
IP=

#Get the Serials
cat /root/.meraki_port_mig/tmp/${IP} >> /root/.meraki_port_mig/hostnames.txt


#Get the hostname
HOSTNAME=$(cat /var/lib/tftpboot/port_switch/${IP} | grep hostname | sed 's/hostname //g')

# Input file
input_file="/root/.meraki_port_mig/hostnames.txt"  # Replace with your input file path

# Check if input file exists
if [[ ! -f "$input_file" ]]; then
    echo "Error: $input_file does not exist."
    exit 1
fi

# Count the number of lines in the input file
line_count=$(wc -l < "$input_file")
#echo "Number of switches considered: $line_count"
#echo " "

sed -i 's/$/,/' "$input_file"
# Insert the variable into lines that end with a comma and have no characters after it
sed -i '/,$/ s/$/ '"$HOSTNAME"'/' "$input_file"
# Use sed to remove anything after the second comma, including the second comma, in each line
sed -i 's/^\([^,]*,[^,]*\),.*/\1/' "$input_file"

echo ${GREEN}"Deploying Update"${TEXTRESET}
unbuffer python3.10 /root/.meraki_port_mig/deploy_hostnames.py
echo " "
#cleanup
rm -f /root/.meraki_port_mig/hostnames.txt