#!/bin/bash
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
#This File is used to parse a stack switch and break it into a single switch config

IP=

#Get Serials for stack
cat /var/lib/tftpboot/mig_switch/${IP}-shmr | grep C9300 |grep -E -o "Q.{0,13}" >> /root/.meraki_mig/serial.txt
sleep 1
#Cut the config down to ports only (remove top portion of config)
sed -n '/interface GigabitEthernet/,$p' /var/lib/tftpboot/mig_switch/${IP} > /root/.meraki_mig/cisco_config.tmp

#Look at config file and see if it's stacked
#For GigabitEthernet
awk 'BEGIN {found=0} /interface GigabitEthernet1\/0\/1/ && !found {print "switch 1"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet2\/0\/1/ && !found {print "switch 2"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet3\/0\/1/ && !found {print "switch 3"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet4\/0\/1/ && !found {print "switch 4"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet5\/0\/1/ && !found {print "switch 5"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet6\/0\/1/ && !found {print "switch 6"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet7\/0\/1/ && !found {print "switch 7"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet8\/0\/1/ && !found {print "switch 8"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet9\/0\/1/ && !found {print "switch 9"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
#For TenGigabitEthernet
awk 'BEGIN {found=0} /interface TenGigabitEthernet1\/0\/1/ && !found {print "switch 1"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet2\/0\/1/ && !found {print "switch 2"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet3\/0\/1/ && !found {print "switch 3"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet4\/0\/1/ && !found {print "switch 4"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet5\/0\/1/ && !found {print "switch 5"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet6\/0\/1/ && !found {print "switch 6"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet7\/0\/1/ && !found {print "switch 7"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet8\/0\/1/ && !found {print "switch 8"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet9\/0\/1/ && !found {print "switch 9"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
#For TwoGigabitEthernet
awk 'BEGIN {found=0} /interface TwoGigabitEthernet1\/0\/1/ && !found {print "switch 1"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet2\/0\/1/ && !found {print "switch 2"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet3\/0\/1/ && !found {print "switch 3"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet4\/0\/1/ && !found {print "switch 4"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet5\/0\/1/ && !found {print "switch 5"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet6\/0\/1/ && !found {print "switch 6"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet7\/0\/1/ && !found {print "switch 7"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet8\/0\/1/ && !found {print "switch 8"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet9\/0\/1/ && !found {print "switch 9"; found=1} {print}' /root/.meraki_mig/cisco_config.tmp > temp && mv -f temp /root/.meraki_mig/cisco_config.tmp


# Input switch stack configuration file
input_file="/root/.meraki_mig/cisco_config.tmp"  # Replace with your config file path

# Directory to store the output files for each switch
output_dir="tmp"
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
            echo "$line" > "$output_file"  # Start a new file for the switch
        elif [[ -n "$current_switch" ]]; then
            echo "$line" >> "$output_file"  # Append lines to the current switch file
        fi
    done < "$input_file"
}

# Main script
parse_config
echo "Configuration files created in $output_dir"


#Parse the serial file and split into separate files

# Input file
input_file="/root/.meraki_mig/serial.txt"  # Replace with your actual input file path

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
    echo "$line" > "$new_filename"

    # Print the name of the created file
    echo "Created file: $new_filename"

    # Increment the file counter
    file_counter=$((file_counter + 1))

done < "$input_file"


##Determine the number of switches in the stack and convert them one by one

#Stacked Switch Config 1
CONFIG1=$(ls /root/.meraki_mig/tmp/switch1.txt 2>/dev/null)
SERIAL1=$(ls /root/.meraki_mig/tmp/serial1.txt 2>/dev/null)
if [[ "$CONFIG1" == "/root/.meraki_mig/tmp/switch1.txt" && "$SERIAL1" == "/root/.meraki_mig/tmp/serial1.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 1 in stack${TEXTRESET}"
    mv /root/.meraki_mig/tmp/switch1.txt /root/.meraki_mig/cisco_config.tmp
    mv /root/.meraki_mig/tmp/serial1.txt /root/.meraki_mig/serial.txt
    #Move the Uplink ports to a separate file
    awk '/interface GigabitEthernet1\/1\/1/ {start = NR; flag = 1} flag {lines[NR] = $0} /interface AppGigabitEthernet1\/0\/1/ {end = NR; flag = 0} END {if (start && end) {for (i=start; i<=end; i++) print lines[i]}}' /root/.meraki_mig/cisco_config.tmp > /root/.meraki_mig/cisco_config_up.tmp
    #Remove the uplinks from the file
    awk '/interface GigabitEthernet1\/1\/1/,/interface AppGigabitEthernet1\/0\/1/{next}1' /root/.meraki_mig/cisco_config.tmp > temp_file && mv -f temp_file /root/.meraki_mig/cisco_config.tmp
    python3.10 /root/.meraki_mig/port_migration.py
    rm -f /root/.meraki_mig/cisco_config.tmp
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    else
    echo " "
fi

#Stacked Switch Config 2
CONFIG2=$(ls /root/.meraki_mig/tmp/switch2.txt 2>/dev/null)
SERIAL2=$(ls /root/.meraki_mig/tmp/serial2.txt 2>/dev/null)
if [[ "$CONFIG2" == "/root/.meraki_mig/tmp/switch2.txt" && "$SERIAL2" == "/root/.meraki_mig/tmp/serial2.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 2 in stack${TEXTRESET}"
    mv /root/.meraki_mig/tmp/switch2.txt /root/.meraki_mig/cisco_config.tmp
    mv /root/.meraki_mig/tmp/serial2.txt /root/.meraki_mig/serial.txt
    #Move the Uplink ports to a separate file
    awk '/interface GigabitEthernet2\/1\/1/ {start = NR; flag = 1} flag {lines[NR] = $0} /interface AppGigabitEthernet2\/0\/1/ {end = NR; flag = 0} END {if (start && end) {for (i=start; i<=end; i++) print lines[i]}}' /root/.meraki_mig/cisco_config.tmp > /root/.meraki_mig/cisco_config_up.tmp
    #Remove the uplinks from the file
    awk '/interface GigabitEthernet2\/1\/1/,/interface AppGigabitEthernet2\/0\/1/{next}1' /root/.meraki_mig/cisco_config.tmp > temp_file && mv -f temp_file /root/.meraki_mig/cisco_config.tmp
    python3.10 /root/.meraki_mig/port_migration.py
    rm -f /root/.meraki_mig/cisco_config.tmp
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    else
    echo " "
fi

#Stacked Switch Config 3
CONFIG3=$(ls /root/.meraki_mig/tmp/switch3.txt 2>/dev/null)
SERIAL3=$(ls /root/.meraki_mig/tmp/serial3.txt 2>/dev/null)
if [[ "$CONFIG3" == "/root/.meraki_mig/tmp/switch3.txt" && "$SERIAL3" == "/root/.meraki_mig/tmp/serial3.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 3 in stack${TEXTRESET}"
    mv /root/.meraki_mig/tmp/switch3.txt /root/.meraki_mig/cisco_config.tmp
    mv /root/.meraki_mig/tmp/serial3.txt /root/.meraki_mig/serial.txt
    #Move the Uplink ports to a separate file
    awk '/interface GigabitEthernet3\/1\/1/ {start = NR; flag = 1} flag {lines[NR] = $0} /interface AppGigabitEthernet3\/0\/1/ {end = NR; flag = 0} END {if (start && end) {for (i=start; i<=end; i++) print lines[i]}}' /root/.meraki_mig/cisco_config.tmp > /root/.meraki_mig/cisco_config_up.tmp
    #Remove the uplinks from the file
    awk '/interface GigabitEthernet3\/1\/1/,/interface AppGigabitEthernet3\/0\/1/{next}1' /root/.meraki_mig/cisco_config.tmp > temp_file && mv -f temp_file /root/.meraki_mig/cisco_config.tmp
    python3.10 /root/.meraki_mig/port_migration.py
    rm -f /root/.meraki_mig/cisco_config.tmp
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    else
    echo " "
fi

#Stacked Switch Config 4
CONFIG4=$(ls /root/.meraki_mig/tmp/switch4.txt 2>/dev/null)
SERIAL4=$(ls /root/.meraki_mig/tmp/serial4.txt 2>/dev/null)
if [[ "$CONFIG4" == "/root/.meraki_mig/tmp/switch4.txt" && "$SERIAL4" == "/root/.meraki_mig/tmp/serial4.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 4 in stack${TEXTRESET}"
    mv /root/.meraki_mig/tmp/switch4.txt /root/.meraki_mig/cisco_config.tmp
    mv /root/.meraki_mig/tmp/serial4.txt /root/.meraki_mig/serial.txt
    #Move the Uplink ports to a separate file
    awk '/interface GigabitEthernet4\/1\/1/ {start = NR; flag = 1} flag {lines[NR] = $0} /interface AppGigabitEthernet4\/0\/1/ {end = NR; flag = 0} END {if (start && end) {for (i=start; i<=end; i++) print lines[i]}}' /root/.meraki_mig/cisco_config.tmp > /root/.meraki_mig/cisco_config_up.tmp
    #Remove the uplinks from the file
    awk '/interface GigabitEthernet4\/1\/1/,/interface AppGigabitEthernet4\/0\/1/{next}1' /root/.meraki_mig/cisco_config.tmp > temp_file && mv -f temp_file /root/.meraki_mig/cisco_config.tmp
    python3.10 /root/.meraki_mig/port_migration.py
    rm -f /root/.meraki_mig/cisco_config.tmp
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    else
    echo " "
fi

#Stacked Switch Config 5
CONFIG5=$(ls /root/.meraki_mig/tmp/switch5.txt 2>/dev/null)
SERIAL5=$(ls /root/.meraki_mig/tmp/serial5.txt 2>/dev/null)
if [[ "$CONFIG5" == "/root/.meraki_mig/tmp/switch5.txt" && "$SERIAL5" == "/root/.meraki_mig/tmp/serial5.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 5 in stack${TEXTRESET}"
    mv /root/.meraki_mig/tmp/switch5.txt /root/.meraki_mig/cisco_config.tmp
    mv /root/.meraki_mig/tmp/serial5.txt /root/.meraki_mig/serial.txt
    #Move the Uplink ports to a separate file
    awk '/interface GigabitEthernet5\/1\/1/ {start = NR; flag = 1} flag {lines[NR] = $0} /interface AppGigabitEthernet5\/0\/1/ {end = NR; flag = 0} END {if (start && end) {for (i=start; i<=end; i++) print lines[i]}}' /root/.meraki_mig/cisco_config.tmp > /root/.meraki_mig/cisco_config_up.tmp
    #Remove the uplinks from the file
    awk '/interface GigabitEthernet5\/1\/1/,/interface AppGigabitEthernet5\/0\/1/{next}1' /root/.meraki_mig/cisco_config.tmp > temp_file && mv -f temp_file /root/.meraki_mig/cisco_config.tmp
    python3.10 /root/.meraki_mig/port_migration.py
    rm -f /root/.meraki_mig/cisco_config.tmp
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    else
    echo " "
fi

#Stacked Switch Config 6
CONFIG6=$(ls /root/.meraki_mig/tmp/switch6.txt 2>/dev/null)
SERIAL6=$(ls /root/.meraki_mig/tmp/serial6.txt 2>/dev/null)
if [[ "$CONFIG6" == "/root/.meraki_mig/tmp/switch6.txt" && "$SERIAL6" == "/root/.meraki_mig/tmp/serial6.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 6 in stack${TEXTRESET}"
    mv /root/.meraki_mig/tmp/switch6.txt /root/.meraki_mig/cisco_config.tmp
    mv /root/.meraki_mig/tmp/serial6.txt /root/.meraki_mig/serial.txt
    #Move the Uplink ports to a separate file
    awk '/interface GigabitEthernet6\/1\/1/ {start = NR; flag = 1} flag {lines[NR] = $0} /interface AppGigabitEthernet6\/0\/1/ {end = NR; flag = 0} END {if (start && end) {for (i=start; i<=end; i++) print lines[i]}}' /root/.meraki_mig/cisco_config.tmp > /root/.meraki_mig/cisco_config_up.tmp
    #Remove the uplinks from the file
    awk '/interface GigabitEthernet6\/1\/1/,/interface AppGigabitEthernet6\/0\/1/{next}1' /root/.meraki_mig/cisco_config.tmp > temp_file && mv -f temp_file /root/.meraki_mig/cisco_config.tmp
    python3.10 /root/.meraki_mig/port_migration.py
    rm -f /root/.meraki_mig/cisco_config.tmp
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    else
    echo " "
fi

#Stacked Switch Config 7
CONFIG7=$(ls /root/.meraki_mig/tmp/switch7.txt 2>/dev/null)
SERIAL7=$(ls /root/.meraki_mig/tmp/serial7.txt 2>/dev/null)
if [[ "$CONFIG7" == "/root/.meraki_mig/tmp/switch7.txt" && "$SERIAL7" == "/root/.meraki_mig/tmp/serial7.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 7 in stack${TEXTRESET}"
    mv /root/.meraki_mig/tmp/switch7.txt /root/.meraki_mig/cisco_config.tmp
    mv /root/.meraki_mig/tmp/serial7.txt /root/.meraki_mig/serial.txt
    #Move the Uplink ports to a separate file
    awk '/interface GigabitEthernet7\/1\/1/ {start = NR; flag = 1} flag {lines[NR] = $0} /interface AppGigabitEthernet7\/0\/1/ {end = NR; flag = 0} END {if (start && end) {for (i=start; i<=end; i++) print lines[i]}}' /root/.meraki_mig/cisco_config.tmp > /root/.meraki_mig/cisco_config_up.tmp
    #Remove the uplinks from the file
    awk '/interface GigabitEthernet7\/1\/1/,/interface AppGigabitEthernet7\/0\/1/{next}1' /root/.meraki_mig/cisco_config.tmp > temp_file && mv -f temp_file /root/.meraki_mig/cisco_config.tmp
    python3.10 /root/.meraki_mig/port_migration.py
    rm -f /root/.meraki_mig/cisco_config.tmp
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    else
    echo " "
fi

#Stacked Switch Config 8
CONFIG8=$(ls /root/.meraki_mig/tmp/switch8.txt 2>/dev/null)
SERIAL8=$(ls /root/.meraki_mig/tmp/serial8.txt 2>/dev/null)
if [[ "$CONFIG8" == "/root/.meraki_mig/tmp/switch8.txt" && "$SERIAL8" == "/root/.meraki_mig/tmp/serial8.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 8 in stack${TEXTRESET}"
    mv /root/.meraki_mig/tmp/switch8.txt /root/.meraki_mig/cisco_config.tmp
    mv /root/.meraki_mig/tmp/serial8.txt /root/.meraki_mig/serial.txt
    #Move the Uplink ports to a separate file
    awk '/interface GigabitEthernet8\/1\/1/ {start = NR; flag = 1} flag {lines[NR] = $0} /interface AppGigabitEthernet8\/0\/1/ {end = NR; flag = 0} END {if (start && end) {for (i=start; i<=end; i++) print lines[i]}}' /root/.meraki_mig/cisco_config.tmp > /root/.meraki_mig/cisco_config_up.tmp
    #Remove the uplinks from the file
    awk '/interface GigabitEthernet8\/1\/1/,/interface AppGigabitEthernet8\/0\/1/{next}1' /root/.meraki_mig/cisco_config.tmp > temp_file && mv -f temp_file /root/.meraki_mig/cisco_config.tmp
    python3.10 /root/.meraki_mig/port_migration.py
    rm -f /root/.meraki_mig/cisco_config.tmp
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    else
    echo " "
fi

#Stacked Switch Config 9
CONFIG9=$(ls /root/.meraki_mig/tmp/switch9.txt 2>/dev/null)
SERIAL9=$(ls /root/.meraki_mig/tmp/serial9.txt 2>/dev/null)
if [[ "$CONFIG9" == "/root/.meraki_mig/tmp/switch9.txt" && "$SERIAL9" == "/root/.meraki_mig/tmp/serial9.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 9 in stack${TEXTRESET}"
    mv /root/.meraki_mig/tmp/switch9.txt /root/.meraki_mig/cisco_config.tmp
    mv /root/.meraki_mig/tmp/serial9.txt /root/.meraki_mig/serial.txt
    #Move the Uplink ports to a separate file
    awk '/interface GigabitEthernet9\/1\/1/ {start = NR; flag = 1} flag {lines[NR] = $0} /interface AppGigabitEthernet9\/0\/1/ {end = NR; flag = 0} END {if (start && end) {for (i=start; i<=end; i++) print lines[i]}}' /root/.meraki_mig/cisco_config.tmp > /root/.meraki_mig/cisco_config_up.tmp
    #Remove the uplinks from the file
    awk '/interface GigabitEthernet9\/1\/1/,/interface AppGigabitEthernet9\/0\/1/{next}1' /root/.meraki_mig/cisco_config.tmp > temp_file && mv -f temp_file /root/.meraki_mig/cisco_config.tmp
    python3.10 /root/.meraki_mig/port_migration.py
    rm -f /root/.meraki_mig/cisco_config.tmp
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    else
    echo " "
fi

rm -f /root/.meraki_mig/serial.txt

echo "Conversion Script Complete"


sleep 1
