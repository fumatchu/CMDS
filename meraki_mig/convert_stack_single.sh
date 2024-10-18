#!/bin/bash
#This File is used to parse a stack switch and break it into a single switch config

IP=192.168.210.153

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
output_dir="switch_configs"
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

#Check the directories for the number of available configs to migrate- if switch 1, then run command, if switch2, etc

