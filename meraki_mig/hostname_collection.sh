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
INPUT="/root/.meraki_mig/ip_list"
clear
echo "############################Collection time ${DATE}######################################"
cat <<EOF
${YELLOW}Migrating Hostnames${TEXTRESET}
*Number of switches is cumulative

EOF

# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo "$IP"

#Get the Serials
cat /var/lib/tftpboot/mig_switch/${IP}-shmr | grep C9300 |grep -E -o "Q.{0,13}" >> /root/.meraki_mig/hostnames.txt

#Get the hostname
HOSTNAME=$(cat /var/lib/tftpboot/mig_switch/${IP} | grep hostname | sed 's/hostname //g')

# Input file
input_file="/root/.meraki_mig/hostnames.txt"  # Replace with your input file path

# Check if input file exists
if [[ ! -f "$input_file" ]]; then
    echo "Error: $input_file does not exist."
    exit 1
fi

# Count the number of lines in the input file
line_count=$(wc -l < "$input_file")
echo "Number of switches considered: $line_count"
echo " "

sed -i 's/$/,/' "$input_file"
# Insert the variable into lines that end with a comma and have no characters after it
sed -i '/,$/ s/$/ '"$HOSTNAME"'/' "$input_file"
# Use sed to remove anything after the second comma, including the second comma, in each line
sed -i 's/^\([^,]*,[^,]*\),.*/\1/' "$input_file"
done <"$INPUT"

echo ${GREEN}"Deploying Update"${TEXTRESET}
unbuffer python3.10 /root/.meraki_mig/deploy_hostnames.py
sleep 2
#cleanup
rm -f /root/.meraki_mig/hostnames.txt
