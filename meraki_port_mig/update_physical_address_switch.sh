#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Update Physical Address on Switches${TEXTRESET}
This will allow you to update Physical Address of the Switch and Move the Map Marker

Please provide the Physical address in the correct format:
(i.e. 123 AnyStreet St. City State ZIP)

EOF

read -p "Please provide the Address you would like to use: " ADDR
while [ -z "$USER" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide the Address you would like to use: " ADDR
done
clear
sleep 1
cat <<EOF
${GREEN}Updating the Switch(es) Physical address with:${TEXTRESET} ${ADDR}

EOF
sleep 2

#Duplicate the Serials file
cat /root/.meraki_port_mig/serial/* | grep -E -o "Q.{0,13}" >/root/.meraki_port_mig/address_switch_serials.txt
#Remove duplicates from the serials file
# Define the file path
file_path="/root/.meraki_port_mig/address_switch_serials.txt"

# Check if the file exists
if [[ -f "$file_path" ]]; then
    # Remove duplicate lines by sorting the file and using uniq
    sort "$file_path" | uniq > "${file_path}.tmp"

    # Replace the original file with the deduplicated file
    mv "${file_path}.tmp" "$file_path"

    echo "Duplicate lines have been removed from $file_path."
else
    echo "File $file_path does not exist."
fi

sed -i '0,/new_address = /{/new_address = /d;}' /root/.meraki_port_mig/update_physical_address_switch.py
echo new_address = "\"${ADDR}\"" >/root/.meraki_port_mig/address.txt
sed -i '32 r /root/.meraki_port_mig/address.txt' /root/.meraki_port_mig/update_physical_address_switch.py


clear
echo "${GREEN}Deploying Script${TEXTRESET}"

python3.10 /root/.meraki_port_mig/update_physical_address_switch.py

echo "${GREEN}Script Complete${TEXTRESET}"
rm -r /root/.meraki_port_mig/address.txt
sleep 1
