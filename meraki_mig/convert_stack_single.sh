#!/bin/bash
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
#This File is used to parse a stack switch and break it into a single switch config

IP=192.168.210.164

#Get Serials for stack
cat /var/lib/tftpboot/mig_switch/${IP}-shmr | grep C9300 | grep -E -o "Q.{0,13}" >>/root/.meraki_mig/serial.txt
sleep 1
#Cut the config down to ports only (remove top portion of config)
sed -n '/interface GigabitEthernet/,$p' /var/lib/tftpboot/mig_switch/${IP} >/root/.meraki_mig/cisco_config.tmp

#Look at config file and see if it's stacked
#For GigabitEthernet
awk 'BEGIN {found=0} /interface GigabitEthernet1\/0\/1/ && !found {print "switch 1"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet2\/0\/1/ && !found {print "switch 2"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet3\/0\/1/ && !found {print "switch 3"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet4\/0\/1/ && !found {print "switch 4"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet5\/0\/1/ && !found {print "switch 5"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet6\/0\/1/ && !found {print "switch 6"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet7\/0\/1/ && !found {print "switch 7"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet8\/0\/1/ && !found {print "switch 8"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet9\/0\/1/ && !found {print "switch 9"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp

#For TwoGigabitEthernet
awk 'BEGIN {found=0} /interface TwoGigabitEthernet1\/0\/1/ && !found {print "switch 1"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet2\/0\/1/ && !found {print "switch 2"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet3\/0\/1/ && !found {print "switch 3"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet4\/0\/1/ && !found {print "switch 4"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet5\/0\/1/ && !found {print "switch 5"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet6\/0\/1/ && !found {print "switch 6"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet7\/0\/1/ && !found {print "switch 7"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet8\/0\/1/ && !found {print "switch 8"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet9\/0\/1/ && !found {print "switch 9"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp

#For FiveGigabitEthernet
awk 'BEGIN {found=0} /interface FiveGigabitEthernet1\/0\/1/ && !found {print "switch 1"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet2\/0\/1/ && !found {print "switch 2"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet3\/0\/1/ && !found {print "switch 3"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet4\/0\/1/ && !found {print "switch 4"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet5\/0\/1/ && !found {print "switch 5"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet6\/0\/1/ && !found {print "switch 6"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet7\/0\/1/ && !found {print "switch 7"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet8\/0\/1/ && !found {print "switch 8"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet9\/0\/1/ && !found {print "switch 9"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp

#For TenGigabitEthernet
awk 'BEGIN {found=0} /interface TenGigabitEthernet1\/0\/1/ && !found {print "switch 1"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet2\/0\/1/ && !found {print "switch 2"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet3\/0\/1/ && !found {print "switch 3"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet4\/0\/1/ && !found {print "switch 4"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet5\/0\/1/ && !found {print "switch 5"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet6\/0\/1/ && !found {print "switch 6"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet7\/0\/1/ && !found {print "switch 7"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet8\/0\/1/ && !found {print "switch 8"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet9\/0\/1/ && !found {print "switch 9"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_mig/cisco_config.tmp


# Input switch stack configuration file
input_file="/root/.meraki_mig/cisco_config.tmp" # Replace with your config file path

# Directory to store the output files for each switch
output_dir="/root/.meraki_mig/tmp"
mkdir -p "$output_dir"

# Parse the configuration file and create a new file for each switch
parse_config() {
    local current_switch=""
    local output_file=""

    while IFS= read -r line; do
        if [[ "$line" =~ ^switch\ ([0-9]+)$ ]]; then
            # Extract the switch number
            switch_number="${BASH_REMATCH[1]}"
            current_switch="switch$switch_number"
            output_file="$output_dir/$current_switch.txt"
            echo "Creating configuration for $current_switch"
            echo "$line" >"$output_file" # Start a new file for the switch
        elif [[ -n "$current_switch" ]]; then
            echo "$line" >>"$output_file" # Append lines to the current switch file
        fi
    done <"$input_file"
}

# Main script
parse_config
echo "Configuration files created in $output_dir"

#Parse the serial file and split into separate files

# Input file
input_file="/root/.meraki_mig/serial.txt" # Replace with your actual input file path

# Base filename for the new files
base_filename="serial"

# Directory to store the new files
output_directory="/root/.meraki_mig/tmp"

# Ensure the output directory exists
mkdir -p "$output_directory"

# Initialize the file counter
file_counter=1

# Read the input file line by line
while IFS= read -r line; do
    # Create the new filename with an incremental number
    new_filename="${output_directory}/${base_filename}${file_counter}.txt"

    # Write the line to the new file
    echo "$line" >"$new_filename"

    # Print the name of the created file
    echo "Created file: $new_filename"

    # Increment the file counter
    file_counter=$((file_counter + 1))

done <"$input_file"

##Determine the number of switches in the stack and convert them one by one

#Stacked Switch Config 1
CONFIG1=$(ls /root/.meraki_mig/tmp/switch1.txt 2>/dev/null)
SERIAL1=$(ls /root/.meraki_mig/tmp/serial1.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_mig/tmp/serial1.txt 2>/dev/null)
if [[ "$CONFIG1" == "/root/.meraki_mig/tmp/switch1.txt" && "$SERIAL1" == "/root/.meraki_mig/tmp/serial1.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 1"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
    \cp -f /root/.meraki_mig/tmp/switch1.txt /root/.meraki_mig/cisco_config.tmp
    \cp -f /root/.meraki_mig/tmp/serial1.txt /root/.meraki_mig/serial.txt
    #Move the Uplink ports to a separate file
    awk '/interface GigabitEthernet1\/1\/1/ {start = NR; flag = 1} flag {lines[NR] = $0} /interface AppGigabitEthernet1\/0\/1/ {end = NR; flag = 0} END {if (start && end) {for (i=start; i<=end; i++) print lines[i]}}' /root/.meraki_mig/cisco_config.tmp >/root/.meraki_mig/cisco_config_up1.tmp
    #Remove the uplinks from the file
    awk '/interface GigabitEthernet1\/1\/1/,/interface AppGigabitEthernet1\/0\/1/{next}1' /root/.meraki_mig/cisco_config.tmp >temp_file && mv -f temp_file /root/.meraki_mig/cisco_config.tmp
    python3.10 /root/.meraki_mig/port_migration.py
    rm -f /root/.meraki_mig/cisco_config.tmp
else
    echo " " > /dev/null
fi

#Stacked Switch Config 2
CONFIG2=$(ls /root/.meraki_mig/tmp/switch2.txt 2>/dev/null)
SERIAL2=$(ls /root/.meraki_mig/tmp/serial2.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_mig/tmp/serial2.txt 2>/dev/null)
if [[ "$CONFIG2" == "/root/.meraki_mig/tmp/switch2.txt" && "$SERIAL2" == "/root/.meraki_mig/tmp/serial2.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 2"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
    \cp -f /root/.meraki_mig/tmp/switch2.txt /root/.meraki_mig/cisco_config.tmp
    \cp -f /root/.meraki_mig/tmp/serial2.txt /root/.meraki_mig/serial.txt
    #Move the Uplink ports to a separate file
    awk '/interface GigabitEthernet2\/1\/1/ {start = NR; flag = 1} flag {lines[NR] = $0} /interface AppGigabitEthernet2\/0\/1/ {end = NR; flag = 0} END {if (start && end) {for (i=start; i<=end; i++) print lines[i]}}' /root/.meraki_mig/cisco_config.tmp >/root/.meraki_mig/cisco_config_up2.tmp
    #Remove the uplinks from the file
    awk '/interface GigabitEthernet2\/1\/1/,/interface AppGigabitEthernet2\/0\/1/{next}1' /root/.meraki_mig/cisco_config.tmp >temp_file && mv -f temp_file /root/.meraki_mig/cisco_config.tmp
    python3.10 /root/.meraki_mig/port_migration.py
    rm -f /root/.meraki_mig/cisco_config.tmp
else
    echo " " > /dev/null
fi

#Stacked Switch Config 3
CONFIG3=$(ls /root/.meraki_mig/tmp/switch3.txt 2>/dev/null)
SERIAL3=$(ls /root/.meraki_mig/tmp/serial3.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_mig/tmp/serial3.txt 2>/dev/null)
if [[ "$CONFIG3" == "/root/.meraki_mig/tmp/switch3.txt" && "$SERIAL3" == "/root/.meraki_mig/tmp/serial3.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 3"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
    \cp -f /root/.meraki_mig/tmp/switch3.txt /root/.meraki_mig/cisco_config.tmp
    \cp -f /root/.meraki_mig/tmp/serial3.txt /root/.meraki_mig/serial.txt
    #Move the Uplink ports to a separate file
    awk '/interface GigabitEthernet3\/1\/1/ {start = NR; flag = 1} flag {lines[NR] = $0} /interface AppGigabitEthernet3\/0\/1/ {end = NR; flag = 0} END {if (start && end) {for (i=start; i<=end; i++) print lines[i]}}' /root/.meraki_mig/cisco_config.tmp >/root/.meraki_mig/cisco_config_up3.tmp
    #Remove the uplinks from the file
    awk '/interface GigabitEthernet3\/1\/1/,/interface AppGigabitEthernet3\/0\/1/{next}1' /root/.meraki_mig/cisco_config.tmp >temp_file && mv -f temp_file /root/.meraki_mig/cisco_config.tmp
    python3.10 /root/.meraki_mig/port_migration.py
    rm -f /root/.meraki_mig/cisco_config.tmp
else
    echo " " > /dev/null
fi

#Stacked Switch Config 4
CONFIG4=$(ls /root/.meraki_mig/tmp/switch4.txt 2>/dev/null)
SERIAL4=$(ls /root/.meraki_mig/tmp/serial4.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_mig/tmp/serial4.txt 2>/dev/null)
if [[ "$CONFIG4" == "/root/.meraki_mig/tmp/switch4.txt" && "$SERIAL4" == "/root/.meraki_mig/tmp/serial4.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 4"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
    \cp -f /root/.meraki_mig/tmp/switch4.txt /root/.meraki_mig/cisco_config.tmp
    \cp -f /root/.meraki_mig/tmp/serial4.txt /root/.meraki_mig/serial.txt
    #Move the Uplink ports to a separate file
    awk '/interface GigabitEthernet4\/1\/1/ {start = NR; flag = 1} flag {lines[NR] = $0} /interface AppGigabitEthernet4\/0\/1/ {end = NR; flag = 0} END {if (start && end) {for (i=start; i<=end; i++) print lines[i]}}' /root/.meraki_mig/cisco_config.tmp >/root/.meraki_mig/cisco_config_up4.tmp
    #Remove the uplinks from the file
    awk '/interface GigabitEthernet4\/1\/1/,/interface AppGigabitEthernet4\/0\/1/{next}1' /root/.meraki_mig/cisco_config.tmp >temp_file && mv -f temp_file /root/.meraki_mig/cisco_config.tmp
    python3.10 /root/.meraki_mig/port_migration.py
    rm -f /root/.meraki_mig/cisco_config.tmp
else
    echo " " > /dev/null
fi

#Stacked Switch Config 5
CONFIG5=$(ls /root/.meraki_mig/tmp/switch5.txt 2>/dev/null)
SERIAL5=$(ls /root/.meraki_mig/tmp/serial5.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_mig/tmp/serial5.txt 2>/dev/null)
if [[ "$CONFIG5" == "/root/.meraki_mig/tmp/switch5.txt" && "$SERIAL5" == "/root/.meraki_mig/tmp/serial5.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 5"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
    \cp -f /root/.meraki_mig/tmp/switch5.txt /root/.meraki_mig/cisco_config.tmp
    \cp -f /root/.meraki_mig/tmp/serial5.txt /root/.meraki_mig/serial.txt
    #Move the Uplink ports to a separate file
    awk '/interface GigabitEthernet5\/1\/1/ {start = NR; flag = 1} flag {lines[NR] = $0} /interface AppGigabitEthernet5\/0\/1/ {end = NR; flag = 0} END {if (start && end) {for (i=start; i<=end; i++) print lines[i]}}' /root/.meraki_mig/cisco_config.tmp >/root/.meraki_mig/cisco_config_up5.tmp
    #Remove the uplinks from the file
    awk '/interface GigabitEthernet5\/1\/1/,/interface AppGigabitEthernet5\/0\/1/{next}1' /root/.meraki_mig/cisco_config.tmp >temp_file && mv -f temp_file /root/.meraki_mig/cisco_config.tmp
    python3.10 /root/.meraki_mig/port_migration.py
    rm -f /root/.meraki_mig/cisco_config.tmp
else
    echo " " > /dev/null
fi

#Stacked Switch Config 6
CONFIG6=$(ls /root/.meraki_mig/tmp/switch6.txt 2>/dev/null)
SERIAL6=$(ls /root/.meraki_mig/tmp/serial6.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_mig/tmp/serial6.txt 2>/dev/null)
if [[ "$CONFIG6" == "/root/.meraki_mig/tmp/switch6.txt" && "$SERIAL6" == "/root/.meraki_mig/tmp/serial6.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 6"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
    \cp -f /root/.meraki_mig/tmp/switch6.txt /root/.meraki_mig/cisco_config.tmp
    \cp -f /root/.meraki_mig/tmp/serial6.txt /root/.meraki_mig/serial.txt
    #Move the Uplink ports to a separate file
    awk '/interface GigabitEthernet6\/1\/1/ {start = NR; flag = 1} flag {lines[NR] = $0} /interface AppGigabitEthernet6\/0\/1/ {end = NR; flag = 0} END {if (start && end) {for (i=start; i<=end; i++) print lines[i]}}' /root/.meraki_mig/cisco_config.tmp >/root/.meraki_mig/cisco_config_up6.tmp
    #Remove the uplinks from the file
    awk '/interface GigabitEthernet6\/1\/1/,/interface AppGigabitEthernet6\/0\/1/{next}1' /root/.meraki_mig/cisco_config.tmp >temp_file && mv -f temp_file /root/.meraki_mig/cisco_config.tmp
    python3.10 /root/.meraki_mig/port_migration.py
    rm -f /root/.meraki_mig/cisco_config.tmp
else
    echo " " > /dev/null
fi

#Stacked Switch Config 7
CONFIG7=$(ls /root/.meraki_mig/tmp/switch7.txt 2>/dev/null)
SERIAL7=$(ls /root/.meraki_mig/tmp/serial7.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_mig/tmp/serial7.txt 2>/dev/null)
if [[ "$CONFIG7" == "/root/.meraki_mig/tmp/switch7.txt" && "$SERIAL7" == "/root/.meraki_mig/tmp/serial7.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 7"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
    \cp -f /root/.meraki_mig/tmp/switch7.txt /root/.meraki_mig/cisco_config.tmp
    \cp -f /root/.meraki_mig/tmp/serial7.txt /root/.meraki_mig/serial.txt
    #Move the Uplink ports to a separate file
    awk '/interface GigabitEthernet7\/1\/1/ {start = NR; flag = 1} flag {lines[NR] = $0} /interface AppGigabitEthernet7\/0\/1/ {end = NR; flag = 0} END {if (start && end) {for (i=start; i<=end; i++) print lines[i]}}' /root/.meraki_mig/cisco_config.tmp >/root/.meraki_mig/cisco_config_up7.tmp
    #Remove the uplinks from the file
    awk '/interface GigabitEthernet7\/1\/1/,/interface AppGigabitEthernet7\/0\/1/{next}1' /root/.meraki_mig/cisco_config.tmp >temp_file && mv -f temp_file /root/.meraki_mig/cisco_config.tmp
    python3.10 /root/.meraki_mig/port_migration.py
    rm -f /root/.meraki_mig/cisco_config.tmp
else
    echo " " > /dev/null
fi

#Stacked Switch Config 8
CONFIG8=$(ls /root/.meraki_mig/tmp/switch8.txt 2>/dev/null)
SERIAL8=$(ls /root/.meraki_mig/tmp/serial8.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_mig/tmp/serial8.txt 2>/dev/null)
if [[ "$CONFIG8" == "/root/.meraki_mig/tmp/switch8.txt" && "$SERIAL8" == "/root/.meraki_mig/tmp/serial8.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 8"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
    \cp -f /root/.meraki_mig/tmp/switch8.txt /root/.meraki_mig/cisco_config.tmp
    \cp -f /root/.meraki_mig/tmp/serial8.txt /root/.meraki_mig/serial.txt
    #Move the Uplink ports to a separate file
    awk '/interface GigabitEthernet8\/1\/1/ {start = NR; flag = 1} flag {lines[NR] = $0} /interface AppGigabitEthernet8\/0\/1/ {end = NR; flag = 0} END {if (start && end) {for (i=start; i<=end; i++) print lines[i]}}' /root/.meraki_mig/cisco_config.tmp >/root/.meraki_mig/cisco_config_up8.tmp
    #Remove the uplinks from the file
    awk '/interface GigabitEthernet8\/1\/1/,/interface AppGigabitEthernet8\/0\/1/{next}1' /root/.meraki_mig/cisco_config.tmp >temp_file && mv -f temp_file /root/.meraki_mig/cisco_config.tmp
    python3.10 /root/.meraki_mig/port_migration.py
    rm -f /root/.meraki_mig/cisco_config.tmp
else
    echo " " > /dev/null
fi

#Stacked Switch Config 9
CONFIG9=$(ls /root/.meraki_mig/tmp/switch9.txt 2>/dev/null)
SERIAL9=$(ls /root/.meraki_mig/tmp/serial9.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_mig/tmp/serial9.txt 2>/dev/null)
if [[ "$CONFIG9" == "/root/.meraki_mig/tmp/switch9.txt" && "$SERIAL9" == "/root/.meraki_mig/tmp/serial9.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 9"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
    \cp -f /root/.meraki_mig/tmp/switch9.txt /root/.meraki_mig/cisco_config.tmp
    \cp -f /root/.meraki_mig/tmp/serial9.txt /root/.meraki_mig/serial.txt
    #Move the Uplink ports to a separate file
    awk '/interface GigabitEthernet9\/1\/1/ {start = NR; flag = 1} flag {lines[NR] = $0} /interface AppGigabitEthernet9\/0\/1/ {end = NR; flag = 0} END {if (start && end) {for (i=start; i<=end; i++) print lines[i]}}' /root/.meraki_mig/cisco_config.tmp >/root/.meraki_mig/cisco_config_up9.tmp
    #Remove the uplinks from the file
    awk '/interface GigabitEthernet9\/1\/1/,/interface AppGigabitEthernet9\/0\/1/{next}1' /root/.meraki_mig/cisco_config.tmp >temp_file && mv -f temp_file /root/.meraki_mig/cisco_config.tmp
    python3.10 /root/.meraki_mig/port_migration.py
    rm -f /root/.meraki_mig/cisco_config.tmp
else
    echo " " > /dev/null
fi

#Determine the Hardware Uplink (NM) for the switch

#Stacked Switch Config 1
CONFIG1=$(ls /root/.meraki_mig/tmp/switch1.txt 2>/dev/null)
SERIAL1=$(ls /root/.meraki_mig/tmp/serial1.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_mig/tmp/serial1.txt 2>/dev/null)
if [[ "$CONFIG1" == "/root/.meraki_mig/tmp/switch1.txt" && "$SERIAL1" == "/root/.meraki_mig/tmp/serial1.txt" ]]; then
    \cp -f /root/.meraki_mig/tmp/switch1.txt /root/.meraki_mig/cisco_config.tmp
    \cp -f /root/.meraki_mig/tmp/serial1.txt /root/.meraki_mig/serial.txt
    echo "${GREEN}${IP}-Found switch 1-Looking for Uplink Ports"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
else
    echo " " > /dev/null
fi

#SWITCH1
#C3850-NM-2-40G 2 x 40
C3850_NM_2_40G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^1.*C3850-NM-2-40G    - Compatible/s/^1.*\(C3850-NM-2-40G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C3850-NM-4-10G 4X10
C3850_NM_4_10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^1.*C3850-NM-4-10G    - Compatible/s/^1.*\(C3850-NM-4-10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C3850-NM-8-10G 8X10
C3850_NM_8_10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^1.*C3850-NM-8-10G    - Compatible/s/^1.*\(C3850-NM-8-10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-2Q Catalyst 9300 Series 2x 40G Network Module
C9300_NM_2Q=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^1.*C9300-NM-2Q    - Compatible/s/^1.*\(C9300-NM-2Q    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-8X Catalyst 9300 Series 8x 10G/1G Network Module
C9300_NM_8X=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^1.*C9300-NM-8X    - Compatible/s/^1.*\(C9300-NM-8X    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-2X40G 2X40
MA_MOD_2X40G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^1.*MA-MOD-2X40G    - Compatible/s/^1.*\(MA-MOD-2X40G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-4X10G 4X10
MA_MOD_4X10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^1.*MA-MOD-4X10G    - Compatible/s/^1.*\(MA-MOD-4X10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-8X10G
MA_MOD_8X10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^1.*MA-MOD-8X10G    - Compatible/s/^1.*\(MA-MOD-8X10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300X-NM-8Y Catalyst 9300X 8x 25G/10G/1G Network Module
C9300X_NM_8Y=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^1.*C9300X-NM-8Y    - Compatible/s/^1.*\(C9300X-NM-8Y    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300X-NM-2C Catalyst 9300X 2x 100G/40G Network Module
C9300X_NM_2C=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^1.*C9300X-NM-2C    - Compatible/s/^1.*\(C9300X-NM-2C    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-2Y Catalyst 9300 Series 2x 25G/10G/1G Network Module
C9300_NM_2Y=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^1.*C9300X-NM-2Y    - Compatible/s/^1.*\(C9300X-NM-2Y    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)

if [ "$C3850_NM_2_40G" = "C3850-NM-2-40G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-2-40G${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up1.tmp
    mv /root/.meraki_mig/cisco_config_up1.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM2X40.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up1.tmp
    echo "${GREEN}Uplink conversion for Switch 1 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C3850_NM_4_10G" = "C3850-NM-4-10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-4-10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up1.tmp
    mv /root/.meraki_mig/cisco_config_up1.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM4X10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up1.tmp
    echo "${GREEN}Uplink conversion for Switch 1 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C3850_NM_8_10G" = "C3850-NM-8-10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-8-10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up1.tmp
    mv /root/.meraki_mig/cisco_config_up1.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM8X10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up1.tmp
    echo "${GREEN}Uplink conversion for Switch 1 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2Q" = "C9300-NM-2Q-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2Q${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up1.tmp
    mv /root/.meraki_mig/cisco_config_up1.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2Q.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up1.tmp
    echo "${GREEN}Uplink conversion for Switch 1 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2Y" = "C9300-NM-2Y-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2Y${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up1.tmp
    mv /root/.meraki_mig/cisco_config_up1.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2Y.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up1.tmp
    echo "${GREEN}Uplink conversion for Switch 1 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2C" = "C9300-NM-2C-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2C${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up1.tmp
    mv /root/.meraki_mig/cisco_config_up1.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2C.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up1.tmp
    echo "${GREEN}Uplink conversion for Switch 1 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_2X40G" = "MA_MOD_2X40G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_2X40G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up1.tmp
    mv /root/.meraki_mig/cisco_config_up1.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD2x40.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up1.tmp
    echo "${GREEN}Uplink conversion for Switch 1 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_4X10G" = "MA-MOD-4X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA-MOD-4X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up1.tmp
    mv /root/.meraki_mig/cisco_config_up1.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-MA-MOD4x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up1.tmp
    echo "${GREEN}Uplink conversion for Switch 1 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_8X" = "C9300-NM-8X-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-8X${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up1.tmp
    mv /root/.meraki_mig/cisco_config_up1.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-8X.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up1.tmp
    echo "${GREEN}Uplink conversion for Switch 1 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_8Y" = "C9300-NM-8Y-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-8Y${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up1.tmp
    mv /root/.meraki_mig/cisco_config_up1.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-8Y.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up1.tmp
    echo "${GREEN}Uplink conversion for Switch 1 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_4X10G" = "MA_MOD_4X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_4X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up1.tmp
    mv /root/.meraki_mig/cisco_config_up1.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD4x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up1.tmp
    echo "${GREEN}Uplink conversion for Switch 1 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi
if [ "$MA_MOD_8X10G" = "MA_MOD_8X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_8X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up1.tmp
    mv /root/.meraki_mig/cisco_config_up1.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD8x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up1.tmp
    echo "${GREEN}Uplink conversion for Switch 1 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

#SWITCH2
#Stacked Switch Config 2
CONFIG2=$(ls /root/.meraki_mig/tmp/switch2.txt 2>/dev/null)
SERIAL2=$(ls /root/.meraki_mig/tmp/serial2.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_mig/tmp/serial2.txt 2>/dev/null)
if [[ "$CONFIG2" == "/root/.meraki_mig/tmp/switch2.txt" && "$SERIAL2" == "/root/.meraki_mig/tmp/serial2.txt" ]]; then
    \cp -f /root/.meraki_mig/tmp/switch2.txt /root/.meraki_mig/cisco_config.tmp
    \cp -f /root/.meraki_mig/tmp/serial2.txt /root/.meraki_mig/serial.txt
    echo "${GREEN}${IP}-Found switch 2-Looking for Uplink Ports"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
else
    echo " "
fi

#C3850-NM-2-40G 2 x 40
C3850_NM_2_40G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^2.*C3850-NM-2-40G    - Compatible/s/^2.*\(C3850-NM-2-40G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C3850-NM-4-10G 4X10
C3850_NM_4_10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^2.*C3850-NM-4-10G    - Compatible/s/^2.*\(C3850-NM-4-10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C3850-NM-8-10G 8X10
C3850_NM_8_10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^2.*C3850-NM-8-10G    - Compatible/s/^2.*\(C3850-NM-8-10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-2Q Catalyst 9300 Series 2x 40G Network Module
C9300_NM_2Q=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^2.*C9300-NM-2Q    - Compatible/s/^2.*\(C9300-NM-2Q    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-8X Catalyst 9300 Series 8x 10G/1G Network Module
C9300_NM_8X=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^2.*C9300-NM-8X    - Compatible/s/^2.*\(C9300-NM-8X    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-2X40G 2X40
MA_MOD_2X40G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^2.*MA-MOD-2X40G    - Compatible/s/^2.*\(MA-MOD-2X40G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-4X10G 4X10
MA_MOD_4X10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^2.*MA-MOD-4X10G    - Compatible/s/^2.*\(MA-MOD-4X10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-8X10G
MA_MOD_8X10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^2.*MA-MOD-8X10G    - Compatible/s/^2.*\(MA-MOD-8X10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300X-NM-8Y Catalyst 9300X 8x 25G/10G/1G Network Module
C9300X_NM_8Y=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^2.*C9300X-NM-8Y    - Compatible/s/^2.*\(C9300X-NM-8Y    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300X-NM-2C Catalyst 9300X 2x 100G/40G Network Module
C9300X_NM_2C=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^2.*C9300X-NM-2C    - Compatible/s/^2.*\(C9300X-NM-2C    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-2Y Catalyst 9300 Series 2x 25G/10G/1G Network Module
C9300_NM_2Y=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^2.*C9300X-NM-2Y    - Compatible/s/^2.*\(C9300X-NM-2Y    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)

if [ "$C3850_NM_2_40G" = "C3850-NM-2-40G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-2-40G${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up2.tmp
    mv /root/.meraki_mig/cisco_config_up2.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM2X40.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up2.tmp
    echo "${GREEN}Uplink conversion for Switch 2 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C3850_NM_4_10G" = "C3850-NM-4-10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-4-10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up2.tmp
    mv /root/.meraki_mig/cisco_config_up2.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM4X10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up2.tmp
    echo "${GREEN}Uplink conversion for Switch 2 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C3850_NM_8_10G" = "C3850-NM-8-10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-8-10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up2.tmp
    mv /root/.meraki_mig/cisco_config_up2.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM8X10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up2.tmp
    echo "${GREEN}Uplink conversion for Switch 2 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2Q" = "C9300-NM-2Q-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2Q${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up2.tmp
    mv /root/.meraki_mig/cisco_config_up2.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2Q.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up2.tmp
    echo "${GREEN}Uplink conversion for Switch 2 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2Y" = "C9300-NM-2Y-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2Y${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up2.tmp
    mv /root/.meraki_mig/cisco_config_up2.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2Y.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up2.tmp
    echo "${GREEN}Uplink conversion for Switch 2 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2C" = "C9300-NM-2C-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2C${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up2.tmp
    mv /root/.meraki_mig/cisco_config_up2.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2C.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up2.tmp
    echo "${GREEN}Uplink conversion for Switch 2 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_2X40G" = "MA_MOD_2X40G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_2X40G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up2.tmp
    mv /root/.meraki_mig/cisco_config_up2.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD2x40.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up2.tmp
    echo "${GREEN}Uplink conversion for Switch 2 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_4X10G" = "MA-MOD-4X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA-MOD-4X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up2.tmp
    mv /root/.meraki_mig/cisco_config_up2.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-MA-MOD4x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up2.tmp
    echo "${GREEN}Uplink conversion for Switch 2 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_8X" = "C9300-NM-8X-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-8X${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up2.tmp
    mv /root/.meraki_mig/cisco_config_up2.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-8X.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up2.tmp
    echo "${GREEN}Uplink conversion for Switch 2 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_8Y" = "C9300-NM-8Y-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-8Y${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up2.tmp
    mv /root/.meraki_mig/cisco_config_up2.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-8Y.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up2.tmp
    echo "${GREEN}Uplink conversion for Switch 2 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_4X10G" = "MA_MOD_4X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_4X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up2.tmp
    mv /root/.meraki_mig/cisco_config_up2.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD4x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up2.tmp
    echo "${GREEN}Uplink conversion for Switch 2 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi
if [ "$MA_MOD_8X10G" = "MA_MOD_8X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_8X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up2.tmp
    mv /root/.meraki_mig/cisco_config_up2.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD8x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up2.tmp
    echo "${GREEN}Uplink conversion for Switch 2 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

#SWITCH3
#Stacked Switch Config 3
CONFIG3=$(ls /root/.meraki_mig/tmp/switch3.txt 2>/dev/null)
SERIAL3=$(ls /root/.meraki_mig/tmp/serial3.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_mig/tmp/serial3.txt 2>/dev/null)
if [[ "$CONFIG3" == "/root/.meraki_mig/tmp/switch3.txt" && "$SERIAL3" == "/root/.meraki_mig/tmp/serial3.txt" ]]; then
    \cp -f /root/.meraki_mig/tmp/switch3.txt /root/.meraki_mig/cisco_config.tmp
    \cp -f /root/.meraki_mig/tmp/serial3.txt /root/.meraki_mig/serial.txt
    echo "${GREEN}${IP}-Found switch 3-Looking for Uplink Ports"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
else
    echo " " > /dev/null
fi

#C3850-NM-2-40G 2 x 40
C3850_NM_2_40G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^3.*C3850-NM-2-40G    - Compatible/s/^3.*\(C3850-NM-2-40G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C3850-NM-4-10G 4X10
C3850_NM_4_10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^3.*C3850-NM-4-10G    - Compatible/s/^3.*\(C3850-NM-4-10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C3850-NM-8-10G 8X10
C3850_NM_8_10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^3.*C3850-NM-8-10G    - Compatible/s/^3.*\(C3850-NM-8-10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-2Q Catalyst 9300 Series 2x 40G Network Module
C9300_NM_2Q=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^3.*C9300-NM-2Q    - Compatible/s/^3.*\(C9300-NM-2Q    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-8X Catalyst 9300 Series 8x 10G/1G Network Module
C9300_NM_8X=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^3.*C9300-NM-8X    - Compatible/s/^3.*\(C9300-NM-8X    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-2X40G 2X40
MA_MOD_2X40G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^3.*MA-MOD-2X40G    - Compatible/s/^3.*\(MA-MOD-2X40G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-4X10G 4X10
MA_MOD_4X10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^3.*MA-MOD-4X10G    - Compatible/s/^3.*\(MA-MOD-4X10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-8X10G
MA_MOD_8X10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^3.*MA-MOD-8X10G    - Compatible/s/^3.*\(MA-MOD-8X10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300X-NM-8Y Catalyst 9300X 8x 25G/10G/1G Network Module
C9300X_NM_8Y=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^3.*C9300X-NM-8Y    - Compatible/s/^3.*\(C9300X-NM-8Y    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300X-NM-2C Catalyst 9300X 2x 100G/40G Network Module
C9300X_NM_2C=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^3.*C9300X-NM-2C    - Compatible/s/^3.*\(C9300X-NM-2C    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-2Y Catalyst 9300 Series 2x 25G/10G/1G Network Module
C9300_NM_2Y=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^3.*C9300X-NM-2Y    - Compatible/s/^3.*\(C9300X-NM-2Y    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)

if [ "$C3850_NM_2_40G" = "C3850-NM-2-40G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-2-40G${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up3.tmp
    mv /root/.meraki_mig/cisco_config_up3.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM2X40.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up3.tmp
    echo "${GREEN}Uplink conversion for Switch 3 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C3850_NM_4_10G" = "C3850-NM-4-10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-4-10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up3.tmp
    mv /root/.meraki_mig/cisco_config_up3.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM4X10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up3.tmp
    echo "${GREEN}Uplink conversion for Switch 3 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C3850_NM_8_10G" = "C3850-NM-8-10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-8-10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up3.tmp
    mv /root/.meraki_mig/cisco_config_up3.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM8X10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up3.tmp
    echo "${GREEN}Uplink conversion for Switch 3 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2Q" = "C9300-NM-2Q-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2Q${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up3.tmp
    mv /root/.meraki_mig/cisco_config_up3.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2Q.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up3.tmp
    echo "${GREEN}Uplink conversion for Switch 3 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2Y" = "C9300-NM-2Y-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2Y${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up3.tmp
    mv /root/.meraki_mig/cisco_config_up3.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2Y.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up3.tmp
    echo "${GREEN}Uplink conversion for Switch 3 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2C" = "C9300-NM-2C-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2C${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up3.tmp
    mv /root/.meraki_mig/cisco_config_up3.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2C.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up3.tmp
    echo "${GREEN}Uplink conversion for Switch 3 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_2X40G" = "MA_MOD_2X40G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_2X40G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up3.tmp
    mv /root/.meraki_mig/cisco_config_up3.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD2x40.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up3.tmp
    echo "${GREEN}Uplink conversion for Switch 3 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_4X10G" = "MA-MOD-4X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA-MOD-4X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up3.tmp
    mv /root/.meraki_mig/cisco_config_up3.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-MA-MOD4x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up3.tmp
    echo "${GREEN}Uplink conversion for Switch 3 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_8X" = "C9300-NM-8X-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-8X${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up3.tmp
    mv /root/.meraki_mig/cisco_config_up3.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-8X.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up3.tmp
    echo "${GREEN}Uplink conversion for Switch 3 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_8Y" = "C9300-NM-8Y-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-8Y${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up3.tmp
    mv /root/.meraki_mig/cisco_config_up3.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-8Y.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up3.tmp
    echo "${GREEN}Uplink conversion for Switch 3 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_4X10G" = "MA_MOD_4X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_4X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up3.tmp
    mv /root/.meraki_mig/cisco_config_up3.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD4x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up3.tmp
    echo "${GREEN}Uplink conversion for Switch 3 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi
if [ "$MA_MOD_8X10G" = "MA_MOD_8X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_8X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up3.tmp
    mv /root/.meraki_mig/cisco_config_up3.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD8x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up3.tmp
    echo "${GREEN}Uplink conversion for Switch 3 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

#SWITCH4
#Stacked Switch Config 4
CONFIG4=$(ls /root/.meraki_mig/tmp/switch4.txt 2>/dev/null)
SERIAL4=$(ls /root/.meraki_mig/tmp/serial4.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_mig/tmp/serial4.txt 2>/dev/null)
if [[ "$CONFIG4" == "/root/.meraki_mig/tmp/switch4.txt" && "$SERIAL4" == "/root/.meraki_mig/tmp/serial4.txt" ]]; then
    \cp -f /root/.meraki_mig/tmp/switch4.txt /root/.meraki_mig/cisco_config.tmp
    \cp -f /root/.meraki_mig/tmp/serial4.txt /root/.meraki_mig/serial.txt
    echo "${GREEN}${IP}-Found switch 4-Looking for Uplink Ports"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
else
    echo " " > /dev/null
fi

#C3850-NM-2-40G 2 x 40
C3850_NM_2_40G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^4.*C3850-NM-2-40G    - Compatible/s/^4.*\(C3850-NM-2-40G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C3850-NM-4-10G 4X10
C3850_NM_4_10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^4.*C3850-NM-4-10G    - Compatible/s/^4.*\(C3850-NM-4-10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C3850-NM-8-10G 8X10
C3850_NM_8_10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^4.*C3850-NM-8-10G    - Compatible/s/^4.*\(C3850-NM-8-10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-2Q Catalyst 9300 Series 2x 40G Network Module
C9300_NM_2Q=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^4.*C9300-NM-2Q    - Compatible/s/^4.*\(C9300-NM-2Q    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-8X Catalyst 9300 Series 8x 10G/1G Network Module
C9300_NM_8X=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^4.*C9300-NM-8X    - Compatible/s/^4.*\(C9300-NM-8X    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-2X40G 2X40
MA_MOD_2X40G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^4.*MA-MOD-2X40G    - Compatible/s/^4.*\(MA-MOD-2X40G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-4X10G 4X10
MA_MOD_4X10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^4.*MA-MOD-4X10G    - Compatible/s/^4.*\(MA-MOD-4X10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-8X10G
MA_MOD_8X10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^4.*MA-MOD-8X10G    - Compatible/s/^4.*\(MA-MOD-8X10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300X-NM-8Y Catalyst 9300X 8x 25G/10G/1G Network Module
C9300X_NM_8Y=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^4.*C9300X-NM-8Y    - Compatible/s/^4.*\(C9300X-NM-8Y    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300X-NM-2C Catalyst 9300X 2x 100G/40G Network Module
C9300X_NM_2C=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^4.*C9300X-NM-2C    - Compatible/s/^4.*\(C9300X-NM-2C    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-2Y Catalyst 9300 Series 2x 25G/10G/1G Network Module
C9300_NM_2Y=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^4.*C9300X-NM-2Y    - Compatible/s/^4.*\(C9300X-NM-2Y    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)

if [ "$C3850_NM_2_40G" = "C3850-NM-2-40G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-2-40G${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up4.tmp
    mv /root/.meraki_mig/cisco_config_up4.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM2X40.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up4.tmp
    echo "${GREEN}Uplink conversion for Switch 4 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C3850_NM_4_10G" = "C3850-NM-4-10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-4-10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up4.tmp
    mv /root/.meraki_mig/cisco_config_up4.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM4X10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up4.tmp
    echo "${GREEN}Uplink conversion for Switch 4 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C3850_NM_8_10G" = "C3850-NM-8-10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-8-10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up4.tmp
    mv /root/.meraki_mig/cisco_config_up4.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM8X10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up4.tmp
    echo "${GREEN}Uplink conversion for Switch 4 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2Q" = "C9300-NM-2Q-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2Q${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up4.tmp
    mv /root/.meraki_mig/cisco_config_up4.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2Q.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up4.tmp
    echo "${GREEN}Uplink conversion for Switch 4 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2Y" = "C9300-NM-2Y-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2Y${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up4.tmp
    mv /root/.meraki_mig/cisco_config_up4.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2Y.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up4.tmp
    echo "${GREEN}Uplink conversion for Switch 4 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2C" = "C9300-NM-2C-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2C${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up4.tmp
    mv /root/.meraki_mig/cisco_config_up4.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2C.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up4.tmp
    echo "${GREEN}Uplink conversion for Switch 4 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_2X40G" = "MA_MOD_2X40G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_2X40G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up4.tmp
    mv /root/.meraki_mig/cisco_config_up4.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD2x40.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up4.tmp
    echo "${GREEN}Uplink conversion for Switch 4 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_4X10G" = "MA-MOD-4X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA-MOD-4X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up4.tmp
    mv /root/.meraki_mig/cisco_config_up4.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-MA-MOD4x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up4.tmp
    echo "${GREEN}Uplink conversion for Switch 4 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_8X" = "C9300-NM-8X-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-8X${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up4.tmp
    mv /root/.meraki_mig/cisco_config_up4.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-8X.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up4.tmp
    echo "${GREEN}Uplink conversion for Switch 4 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_8Y" = "C9300-NM-8Y-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-8Y${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up4.tmp
    mv /root/.meraki_mig/cisco_config_up4.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-8Y.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up4.tmp
    echo "${GREEN}Uplink conversion for Switch 4 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_4X10G" = "MA_MOD_4X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_4X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up4.tmp
    mv /root/.meraki_mig/cisco_config_up4.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD4x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up4.tmp
    echo "${GREEN}Uplink conversion for Switch 4 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi
if [ "$MA_MOD_8X10G" = "MA_MOD_8X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_8X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up4.tmp
    mv /root/.meraki_mig/cisco_config_up4.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD8x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up4.tmp
    echo "${GREEN}Uplink conversion for Switch 4 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

#SWITCH5
#Stacked Switch Config 5
CONFIG5=$(ls /root/.meraki_mig/tmp/switch5.txt 2>/dev/null)
SERIAL5=$(ls /root/.meraki_mig/tmp/serial5.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_mig/tmp/serial5.txt 2>/dev/null)
if [[ "$CONFIG5" == "/root/.meraki_mig/tmp/switch5.txt" && "$SERIAL5" == "/root/.meraki_mig/tmp/serial5.txt" ]]; then
    \cp -f /root/.meraki_mig/tmp/switch5.txt /root/.meraki_mig/cisco_config.tmp
    \cp -f /root/.meraki_mig/tmp/serial5.txt /root/.meraki_mig/serial.txt
    echo "${GREEN}${IP}-Found switch 5-Looking for Uplink Ports"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
else
    echo " " > /dev/null
fi

#C3850-NM-2-40G 2 x 40
C3850_NM_2_40G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^5.*C3850-NM-2-40G    - Compatible/s/^5.*\(C3850-NM-2-40G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C3850-NM-4-10G 4X10
C3850_NM_4_10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^5.*C3850-NM-4-10G    - Compatible/s/^5.*\(C3850-NM-4-10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C3850-NM-8-10G 8X10
C3850_NM_8_10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^5.*C3850-NM-8-10G    - Compatible/s/^5.*\(C3850-NM-8-10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-2Q Catalyst 9300 Series 2x 40G Network Module
C9300_NM_2Q=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^5.*C9300-NM-2Q    - Compatible/s/^5.*\(C9300-NM-2Q    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-8X Catalyst 9300 Series 8x 10G/1G Network Module
C9300_NM_8X=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^5.*C9300-NM-8X    - Compatible/s/^5.*\(C9300-NM-8X    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-2X40G 2X40
MA_MOD_2X40G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^5.*MA-MOD-2X40G    - Compatible/s/^5.*\(MA-MOD-2X40G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-4X10G 4X10
MA_MOD_4X10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^5.*MA-MOD-4X10G    - Compatible/s/^5.*\(MA-MOD-4X10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-8X10G
MA_MOD_8X10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^5.*MA-MOD-8X10G    - Compatible/s/^5.*\(MA-MOD-8X10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300X-NM-8Y Catalyst 9300X 8x 25G/10G/1G Network Module
C9300X_NM_8Y=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^5.*C9300X-NM-8Y    - Compatible/s/^5.*\(C9300X-NM-8Y    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300X-NM-2C Catalyst 9300X 2x 100G/40G Network Module
C9300X_NM_2C=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^5.*C9300X-NM-2C    - Compatible/s/^5.*\(C9300X-NM-2C    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-2Y Catalyst 9300 Series 2x 25G/10G/1G Network Module
C9300_NM_2Y=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^5.*C9300X-NM-2Y    - Compatible/s/^5.*\(C9300X-NM-2Y    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)

if [ "$C3850_NM_2_40G" = "C3850-NM-2-40G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-2-40G${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up5.tmp
    mv /root/.meraki_mig/cisco_config_up5.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM2X40.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up5.tmp
    echo "${GREEN}Uplink conversion for Switch 5 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C3850_NM_4_10G" = "C3850-NM-4-10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-4-10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up5.tmp
    mv /root/.meraki_mig/cisco_config_up5.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM4X10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up5.tmp
    echo "${GREEN}Uplink conversion for Switch 5 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C3850_NM_8_10G" = "C3850-NM-8-10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-8-10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up5.tmp
    mv /root/.meraki_mig/cisco_config_up5.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM8X10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up5.tmp
    echo "${GREEN}Uplink conversion for Switch 5 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2Q" = "C9300-NM-2Q-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2Q${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up5.tmp
    mv /root/.meraki_mig/cisco_config_up5.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2Q.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up5.tmp
    echo "${GREEN}Uplink conversion for Switch 5 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2Y" = "C9300-NM-2Y-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2Y${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up5.tmp
    mv /root/.meraki_mig/cisco_config_up5.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2Y.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up5.tmp
    echo "${GREEN}Uplink conversion for Switch 5 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2C" = "C9300-NM-2C-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2C${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up5.tmp
    mv /root/.meraki_mig/cisco_config_up5.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2C.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up5.tmp
    echo "${GREEN}Uplink conversion for Switch 5 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_2X40G" = "MA_MOD_2X40G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_2X40G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up5.tmp
    mv /root/.meraki_mig/cisco_config_up5.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD2x40.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up5.tmp
    echo "${GREEN}Uplink conversion for Switch 5 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_4X10G" = "MA-MOD-4X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA-MOD-4X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up5.tmp
    mv /root/.meraki_mig/cisco_config_up5.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-MA-MOD4x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up5.tmp
    echo "${GREEN}Uplink conversion for Switch 5 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_8X" = "C9300-NM-8X-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-8X${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up5.tmp
    mv /root/.meraki_mig/cisco_config_up5.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-8X.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up5.tmp
    echo "${GREEN}Uplink conversion for Switch 5 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_8Y" = "C9300-NM-8Y-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-8Y${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up5.tmp
    mv /root/.meraki_mig/cisco_config_up5.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-8Y.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up5.tmp
    echo "${GREEN}Uplink conversion for Switch 5 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_4X10G" = "MA_MOD_4X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_4X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up5.tmp
    mv /root/.meraki_mig/cisco_config_up5.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD4x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up5.tmp
    echo "${GREEN}Uplink conversion for Switch 5 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi
if [ "$MA_MOD_8X10G" = "MA_MOD_8X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_8X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up5.tmp
    mv /root/.meraki_mig/cisco_config_up5.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD8x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up5.tmp
    echo "${GREEN}Uplink conversion for Switch 5 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

#SWITCH6
#Stacked Switch Config 6
CONFIG6=$(ls /root/.meraki_mig/tmp/switch6.txt 2>/dev/null)
SERIAL6=$(ls /root/.meraki_mig/tmp/serial6.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_mig/tmp/serial6.txt 2>/dev/null)
if [[ "$CONFIG6" == "/root/.meraki_mig/tmp/switch6.txt" && "$SERIAL6" == "/root/.meraki_mig/tmp/serial6.txt" ]]; then
    \cp -f /root/.meraki_mig/tmp/switch6.txt /root/.meraki_mig/cisco_config.tmp
    \cp -f /root/.meraki_mig/tmp/serial6.txt /root/.meraki_mig/serial.txt
    echo "${GREEN}${IP}-Found switch 6-Looking for Uplink Ports"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
else
    echo " " > /dev/null
fi

#C3850-NM-2-40G 2 x 40
C3850_NM_2_40G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^6.*C3850-NM-2-40G    - Compatible/s/^6.*\(C3850-NM-2-40G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C3850-NM-4-10G 4X10
C3850_NM_4_10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^6.*C3850-NM-4-10G    - Compatible/s/^6.*\(C3850-NM-4-10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C3850-NM-8-10G 8X10
C3850_NM_8_10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^6.*C3850-NM-8-10G    - Compatible/s/^6.*\(C3850-NM-8-10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-2Q Catalyst 9300 Series 2x 40G Network Module
C9300_NM_2Q=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^6.*C9300-NM-2Q    - Compatible/s/^6.*\(C9300-NM-2Q    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-8X Catalyst 9300 Series 8x 10G/1G Network Module
C9300_NM_8X=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^6.*C9300-NM-8X    - Compatible/s/^6.*\(C9300-NM-8X    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-2X40G 2X40
MA_MOD_2X40G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^6.*MA-MOD-2X40G    - Compatible/s/^6.*\(MA-MOD-2X40G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-4X10G 4X10
MA_MOD_4X10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^6.*MA-MOD-4X10G    - Compatible/s/^6.*\(MA-MOD-4X10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-8X10G
MA_MOD_8X10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^6.*MA-MOD-8X10G    - Compatible/s/^6.*\(MA-MOD-8X10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300X-NM-8Y Catalyst 9300X 8x 25G/10G/1G Network Module
C9300X_NM_8Y=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^6.*C9300X-NM-8Y    - Compatible/s/^6.*\(C9300X-NM-8Y    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300X-NM-2C Catalyst 9300X 2x 100G/40G Network Module
C9300X_NM_2C=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^6.*C9300X-NM-2C    - Compatible/s/^6.*\(C9300X-NM-2C    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-2Y Catalyst 9300 Series 2x 25G/10G/1G Network Module
C9300_NM_2Y=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^6.*C9300X-NM-2Y    - Compatible/s/^6.*\(C9300X-NM-2Y    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)

if [ "$C3850_NM_2_40G" = "C3850-NM-2-40G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-2-40G${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up6.tmp
    mv /root/.meraki_mig/cisco_config_up6.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM2X40.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up6.tmp
    echo "${GREEN}Uplink conversion for Switch 6 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C3850_NM_4_10G" = "C3850-NM-4-10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-4-10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up6.tmp
    mv /root/.meraki_mig/cisco_config_up6.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM4X10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up6.tmp
    echo "${GREEN}Uplink conversion for Switch 6 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C3850_NM_8_10G" = "C3850-NM-8-10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-8-10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up6.tmp
    mv /root/.meraki_mig/cisco_config_up6.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM8X10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up6.tmp
    echo "${GREEN}Uplink conversion for Switch 6 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2Q" = "C9300-NM-2Q-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2Q${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up6.tmp
    mv /root/.meraki_mig/cisco_config_up6.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2Q.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up6.tmp
    echo "${GREEN}Uplink conversion for Switch 6 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2Y" = "C9300-NM-2Y-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2Y${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up6.tmp
    mv /root/.meraki_mig/cisco_config_up6.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2Y.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up6.tmp
    echo "${GREEN}Uplink conversion for Switch 6 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2C" = "C9300-NM-2C-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2C${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up6.tmp
    mv /root/.meraki_mig/cisco_config_up6.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2C.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up6.tmp
    echo "${GREEN}Uplink conversion for Switch 6 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_2X40G" = "MA_MOD_2X40G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_2X40G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up6.tmp
    mv /root/.meraki_mig/cisco_config_up6.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD2x40.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up6.tmp
    echo "${GREEN}Uplink conversion for Switch 6 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_4X10G" = "MA-MOD-4X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA-MOD-4X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up6.tmp
    mv /root/.meraki_mig/cisco_config_up6.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-MA-MOD4x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up6.tmp
    echo "${GREEN}Uplink conversion for Switch 6 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_8X" = "C9300-NM-8X-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-8X${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up6.tmp
    mv /root/.meraki_mig/cisco_config_up6.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-8X.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up6.tmp
    echo "${GREEN}Uplink conversion for Switch 6 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_8Y" = "C9300-NM-8Y-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-8Y${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up6.tmp
    mv /root/.meraki_mig/cisco_config_up6.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-8Y.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up6.tmp
    echo "${GREEN}Uplink conversion for Switch 6 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_4X10G" = "MA_MOD_4X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_4X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up6.tmp
    mv /root/.meraki_mig/cisco_config_up6.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD4x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up6.tmp
    echo "${GREEN}Uplink conversion for Switch 6 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi
if [ "$MA_MOD_8X10G" = "MA_MOD_8X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_8X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up6.tmp
    mv /root/.meraki_mig/cisco_config_up6.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD8x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up6.tmp
    echo "${GREEN}Uplink conversion for Switch 6 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

#SWITCH7
#Stacked Switch Config 7
CONFIG7=$(ls /root/.meraki_mig/tmp/switch7.txt 2>/dev/null)
SERIAL7=$(ls /root/.meraki_mig/tmp/serial7.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_mig/tmp/serial7.txt 2>/dev/null)
if [[ "$CONFIG7" == "/root/.meraki_mig/tmp/switch7.txt" && "$SERIAL7" == "/root/.meraki_mig/tmp/serial7.txt" ]]; then
    \cp -f /root/.meraki_mig/tmp/switch7.txt /root/.meraki_mig/cisco_config.tmp
    \cp -f /root/.meraki_mig/tmp/serial7.txt /root/.meraki_mig/serial.txt
    echo "${GREEN}${IP}-Found switch 7-Looking for Uplink Ports"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
else
    echo " " > /dev/null
fi

#C3850-NM-2-40G 2 x 40
C3850_NM_2_40G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^7.*C3850-NM-2-40G    - Compatible/s/^7.*\(C3850-NM-2-40G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C3850-NM-4-10G 4X10
C3850_NM_4_10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^7.*C3850-NM-4-10G    - Compatible/s/^7.*\(C3850-NM-4-10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C3850-NM-8-10G 8X10
C3850_NM_8_10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^7.*C3850-NM-8-10G    - Compatible/s/^7.*\(C3850-NM-8-10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-2Q Catalyst 9300 Series 2x 40G Network Module
C9300_NM_2Q=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^7.*C9300-NM-2Q    - Compatible/s/^7.*\(C9300-NM-2Q    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-8X Catalyst 9300 Series 8x 10G/1G Network Module
C9300_NM_8X=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^7.*C9300-NM-8X    - Compatible/s/^7.*\(C9300-NM-8X    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-2X40G 2X40
MA_MOD_2X40G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^7.*MA-MOD-2X40G    - Compatible/s/^7.*\(MA-MOD-2X40G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-4X10G 4X10
MA_MOD_4X10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^7.*MA-MOD-4X10G    - Compatible/s/^7.*\(MA-MOD-4X10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-8X10G
MA_MOD_8X10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^7.*MA-MOD-8X10G    - Compatible/s/^7.*\(MA-MOD-8X10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300X-NM-8Y Catalyst 9300X 8x 25G/10G/1G Network Module
C9300X_NM_8Y=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^7.*C9300X-NM-8Y    - Compatible/s/^7.*\(C9300X-NM-8Y    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300X-NM-2C Catalyst 9300X 2x 100G/40G Network Module
C9300X_NM_2C=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^7.*C9300X-NM-2C    - Compatible/s/^7.*\(C9300X-NM-2C    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-2Y Catalyst 9300 Series 2x 25G/10G/1G Network Module
C9300_NM_2Y=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^7.*C9300X-NM-2Y    - Compatible/s/^7.*\(C9300X-NM-2Y    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)

if [ "$C3850_NM_2_40G" = "C3850-NM-2-40G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-2-40G${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up7.tmp
    mv /root/.meraki_mig/cisco_config_up7.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM2X40.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up7.tmp
    echo "${GREEN}Uplink conversion for Switch 7 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C3850_NM_4_10G" = "C3850-NM-4-10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-4-10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up7.tmp
    mv /root/.meraki_mig/cisco_config_up7.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM4X10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up7.tmp
    echo "${GREEN}Uplink conversion for Switch 7 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C3850_NM_8_10G" = "C3850-NM-8-10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-8-10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up7.tmp
    mv /root/.meraki_mig/cisco_config_up7.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM8X10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up7.tmp
    echo "${GREEN}Uplink conversion for Switch 7 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2Q" = "C9300-NM-2Q-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2Q${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up7.tmp
    mv /root/.meraki_mig/cisco_config_up7.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2Q.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up7.tmp
    echo "${GREEN}Uplink conversion for Switch 7 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2Y" = "C9300-NM-2Y-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2Y${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up7.tmp
    mv /root/.meraki_mig/cisco_config_up7.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2Y.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up7.tmp
    echo "${GREEN}Uplink conversion for Switch 7 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2C" = "C9300-NM-2C-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2C${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up7.tmp
    mv /root/.meraki_mig/cisco_config_up7.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2C.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up7.tmp
    echo "${GREEN}Uplink conversion for Switch 7 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_2X40G" = "MA_MOD_2X40G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_2X40G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up7.tmp
    mv /root/.meraki_mig/cisco_config_up7.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD2x40.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up7.tmp
    echo "${GREEN}Uplink conversion for Switch 7 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_4X10G" = "MA-MOD-4X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA-MOD-4X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up7.tmp
    mv /root/.meraki_mig/cisco_config_up7.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-MA-MOD4x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up7.tmp
    echo "${GREEN}Uplink conversion for Switch 7 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_8X" = "C9300-NM-8X-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-8X${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up7.tmp
    mv /root/.meraki_mig/cisco_config_up7.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-8X.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up7.tmp
    echo "${GREEN}Uplink conversion for Switch 7 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_8Y" = "C9300-NM-8Y-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-8Y${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up7.tmp
    mv /root/.meraki_mig/cisco_config_up7.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-8Y.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up7.tmp
    echo "${GREEN}Uplink conversion for Switch 7 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_4X10G" = "MA_MOD_4X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_4X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up7.tmp
    mv /root/.meraki_mig/cisco_config_up7.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD4x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up7.tmp
    echo "${GREEN}Uplink conversion for Switch 7 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi
if [ "$MA_MOD_8X10G" = "MA_MOD_8X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_8X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up7.tmp
    mv /root/.meraki_mig/cisco_config_up7.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD8x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up7.tmp
    echo "${GREEN}Uplink conversion for Switch 7 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

#SWITCH8
#Stacked Switch Config 8
CONFIG8=$(ls /root/.meraki_mig/tmp/switch8.txt 2>/dev/null)
SERIAL8=$(ls /root/.meraki_mig/tmp/serial8.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_mig/tmp/serial8.txt 2>/dev/null)
if [[ "$CONFIG8" == "/root/.meraki_mig/tmp/switch8.txt" && "$SERIAL8" == "/root/.meraki_mig/tmp/serial8.txt" ]]; then
    \cp -f /root/.meraki_mig/tmp/switch8.txt /root/.meraki_mig/cisco_config.tmp
    \cp -f /root/.meraki_mig/tmp/serial8.txt /root/.meraki_mig/serial.txt
    echo "${GREEN}${IP}-Found switch 8-Looking for Uplink Ports"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
else
    echo " " > /dev/null
fi

#C3850-NM-2-40G 2 x 40
C3850_NM_2_40G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^8.*C3850-NM-2-40G    - Compatible/s/^8.*\(C3850-NM-2-40G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C3850-NM-4-10G 4X10
C3850_NM_4_10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^8.*C3850-NM-4-10G    - Compatible/s/^8.*\(C3850-NM-4-10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C3850-NM-8-10G 8X10
C3850_NM_8_10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^8.*C3850-NM-8-10G    - Compatible/s/^8.*\(C3850-NM-8-10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-2Q Catalyst 9300 Series 2x 40G Network Module
C9300_NM_2Q=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^8.*C9300-NM-2Q    - Compatible/s/^8.*\(C9300-NM-2Q    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-8X Catalyst 9300 Series 8x 10G/1G Network Module
C9300_NM_8X=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^8.*C9300-NM-8X    - Compatible/s/^8.*\(C9300-NM-8X    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-2X40G 2X40
MA_MOD_2X40G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^8.*MA-MOD-2X40G    - Compatible/s/^8.*\(MA-MOD-2X40G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-4X10G 4X10
MA_MOD_4X10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^8.*MA-MOD-4X10G    - Compatible/s/^8.*\(MA-MOD-4X10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#MA-MOD-8X10G
MA_MOD_8X10G=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^8.*MA-MOD-8X10G    - Compatible/s/^8.*\(MA-MOD-8X10G    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300X-NM-8Y Catalyst 9300X 8x 25G/10G/1G Network Module
C9300X_NM_8Y=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^8.*C9300X-NM-8Y    - Compatible/s/^8.*\(C9300X-NM-8Y    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300X-NM-2C Catalyst 9300X 2x 100G/40G Network Module
C9300X_NM_2C=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^8.*C9300X-NM-2C    - Compatible/s/^8.*\(C9300X-NM-2C    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)
#C9300-NM-2Y Catalyst 9300 Series 2x 25G/10G/1G Network Module
C9300_NM_2Y=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | sed -n '/^8.*C9300X-NM-2Y    - Compatible/s/^8.*\(C9300X-NM-2Y    - Compatible\).*$/\1/p' | tr -d ' ' 2>/dev/null)

if [ "$C3850_NM_2_40G" = "C3850-NM-2-40G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-2-40G${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up8.tmp
    mv /root/.meraki_mig/cisco_config_up8.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM2X40.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up8.tmp
    echo "${GREEN}Uplink conversion for Switch 8 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C3850_NM_4_10G" = "C3850-NM-4-10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-4-10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up8.tmp
    mv /root/.meraki_mig/cisco_config_up8.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM4X10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up8.tmp
    echo "${GREEN}Uplink conversion for Switch 8 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C3850_NM_8_10G" = "C3850-NM-8-10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C3850-NM-8-10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up8.tmp
    mv /root/.meraki_mig/cisco_config_up8.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-3850-NM8X10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up8.tmp
    echo "${GREEN}Uplink conversion for Switch 8 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2Q" = "C9300-NM-2Q-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2Q${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up8.tmp
    mv /root/.meraki_mig/cisco_config_up8.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2Q.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up8.tmp
    echo "${GREEN}Uplink conversion for Switch 8 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2Y" = "C9300-NM-2Y-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2Y${TEXTRESET}"
    echo "${GREEN}Migrating FortyGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up8.tmp
    mv /root/.meraki_mig/cisco_config_up8.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2Y.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up8.tmp
    echo "${GREEN}Uplink conversion for Switch 8 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_2C" = "C9300-NM-2C-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-2C${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up8.tmp
    mv /root/.meraki_mig/cisco_config_up8.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-2C.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up8.tmp
    echo "${GREEN}Uplink conversion for Switch 8 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_2X40G" = "MA_MOD_2X40G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_2X40G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/^interface Ten\|^interface Gigabit\|^interface TwentyFive/d' /root/.meraki_mig/cisco_config_up8.tmp
    mv /root/.meraki_mig/cisco_config_up8.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD2x40.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up8.tmp
    echo "${GREEN}Uplink conversion for Switch 8 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$MA_MOD_4X10G" = "MA-MOD-4X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA-MOD-4X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up8.tmp
    mv /root/.meraki_mig/cisco_config_up8.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-MA-MOD4x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up8.tmp
    echo "${GREEN}Uplink conversion for Switch 8 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_8X" = "C9300-NM-8X-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-8X${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up8.tmp
    mv /root/.meraki_mig/cisco_config_up8.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-8X.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up8.tmp
    echo "${GREEN}Uplink conversion for Switch 8 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

if [ "$C9300_NM_8Y" = "C9300-NM-8Y-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module C9300-NM-8Y${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up8.tmp
    mv /root/.meraki_mig/cisco_config_up8.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-C9300-NM-8Y.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up8.tmp
    echo "${GREEN}Uplink conversion for Switch 8 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else 
    echo " " > /dev/null
fi

if [ "$MA_MOD_4X10G" = "MA_MOD_4X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_4X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up8.tmp
    mv /root/.meraki_mig/cisco_config_up8.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD4x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up8.tmp
    echo "${GREEN}Uplink conversion for Switch 8 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi
if [ "$MA_MOD_8X10G" = "MA_MOD_8X10G-Compatible" ]; then
    echo "${GREEN}${IP}-Found Network Module MA_MOD_8X10G${TEXTRESET}"
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_mig/cisco_config_up8.tmp
    mv /root/.meraki_mig/cisco_config_up8.tmp /root/.meraki_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_mig/port_mig-port_mig-MA-MOD8x10.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up8.tmp
    echo "${GREEN}Uplink conversion for Switch 8 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

rm -f /root/.meraki_mig/serial.txt
rm -f /root/.meraki_mig/cisco_config.tmp
rm -f /root/.meraki_mig/tmp/*
echo "${IP}-Conversion Script Complete"

sleep 1
