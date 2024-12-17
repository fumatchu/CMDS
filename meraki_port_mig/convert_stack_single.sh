#!/bin/bash
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
#This File is used to parse a stack switch and break it into a single switch config

IP=

#Get Serials for stack
cat /root/.meraki_port_mig/serial/${IP} >>/root/.meraki_port_mig/serial.txt
sleep 1
#Cut the config down to ports only (remove top portion of config)
sed -n '/interface GigabitEthernet/,$p' /var/lib/tftpboot/port_switch/${IP} >/root/.meraki_port_mig/cisco_config.tmp

#Look at config file and see if it's stacked
#For GigabitEthernet
awk 'BEGIN {found=0} /interface GigabitEthernet1\/0\/1/ && !found {print "switch 1"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet2\/0\/1/ && !found {print "switch 2"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet3\/0\/1/ && !found {print "switch 3"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet4\/0\/1/ && !found {print "switch 4"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet5\/0\/1/ && !found {print "switch 5"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet6\/0\/1/ && !found {print "switch 6"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet7\/0\/1/ && !found {print "switch 7"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet8\/0\/1/ && !found {print "switch 8"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet9\/0\/1/ && !found {print "switch 9"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp

#For TwoGigabitEthernet
awk 'BEGIN {found=0} /interface TwoGigabitEthernet1\/0\/1/ && !found {print "switch 1"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet2\/0\/1/ && !found {print "switch 2"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet3\/0\/1/ && !found {print "switch 3"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet4\/0\/1/ && !found {print "switch 4"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet5\/0\/1/ && !found {print "switch 5"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet6\/0\/1/ && !found {print "switch 6"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet7\/0\/1/ && !found {print "switch 7"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet8\/0\/1/ && !found {print "switch 8"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet9\/0\/1/ && !found {print "switch 9"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp

#For FiveGigabitEthernet
awk 'BEGIN {found=0} /interface FiveGigabitEthernet1\/0\/1/ && !found {print "switch 1"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet2\/0\/1/ && !found {print "switch 2"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet3\/0\/1/ && !found {print "switch 3"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet4\/0\/1/ && !found {print "switch 4"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet5\/0\/1/ && !found {print "switch 5"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet6\/0\/1/ && !found {print "switch 6"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet7\/0\/1/ && !found {print "switch 7"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet8\/0\/1/ && !found {print "switch 8"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet9\/0\/1/ && !found {print "switch 9"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp

#For TenGigabitEthernet
awk 'BEGIN {found=0} /interface TenGigabitEthernet1\/0\/1/ && !found {print "switch 1"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet2\/0\/1/ && !found {print "switch 2"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet3\/0\/1/ && !found {print "switch 3"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet4\/0\/1/ && !found {print "switch 4"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet5\/0\/1/ && !found {print "switch 5"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet6\/0\/1/ && !found {print "switch 6"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet7\/0\/1/ && !found {print "switch 7"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet8\/0\/1/ && !found {print "switch 8"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TenGigabitEthernet9\/0\/1/ && !found {print "switch 9"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp


# Input switch stack configuration file
input_file="/root/.meraki_port_mig/cisco_config.tmp" # Replace with your config file path

# Directory to store the output files for each switch
output_dir="/root/.meraki_port_mig/tmp"
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
input_file="/root/.meraki_port_mig/serial.txt" # Replace with your actual input file path

# Base filename for the new files
base_filename="serial"

# Directory to store the new files
output_directory="/root/.meraki_port_mig/tmp"

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

#When merging ports, the serial number and switch number no longer align when they are stacks (i.e. serial2 switch3). we must correct this
# Source directory containing the files
source_dir="/root/.meraki_port_mig/tmp"

# Temporary directory for renaming process (ensure it's empty or use a unique path)
temp_dir="${source_dir}/temp_rename"

# Create the temporary directory
mkdir -p "$temp_dir"

# Move to the source directory
cd "$source_dir" || exit

# List and sort serial files and switch files
serial_files=(serial*.txt)
switch_files=(switch*.txt)

# Sort both arrays to ensure they are in numerical order
IFS=$'\n' serial_files=($(sort -V <<<"${serial_files[*]}"))
IFS=$'\n' switch_files=($(sort -V <<<"${switch_files[*]}"))

# Check if the file names are already aligned
aligned=true
for i in "${!serial_files[@]}"; do
  if [ "$i" -lt "${#switch_files[@]}" ]; then
    # Extract the numeric part from the serial file name
    serial_number="${serial_files[$i]//[!0-9]/}"

    # Determine the expected switch file name
    expected_switch_file="switch${serial_number}.txt"

    if [ "${switch_files[$i]}" != "$expected_switch_file" ]; then
      aligned=false
      break
    fi
  fi
done

# If already aligned, do nothing
if $aligned; then
  echo "Files are already aligned. No changes made."
  # Clean up temporary directory
  rmdir "$temp_dir"
  #exit 0 #Script fails when files ARE aligned 
fi

# Rename switch files to align with serial numbers
for i in "${!serial_files[@]}"; do
  if [ "$i" -lt "${#switch_files[@]}" ]; then
    # Extract the numeric part from the serial file name
    serial_number="${serial_files[$i]//[!0-9]/}"

    # Determine the new switch file name
    new_switch_file="switch${serial_number}.txt"

    # Move the switch file to the temporary directory with the new name
    mv "${switch_files[$i]}" "$temp_dir/$new_switch_file"
    echo "Renamed ${switch_files[$i]} to $new_switch_file"
  fi
done

# Move the renamed files back to the source directory
mv "$temp_dir"/* "$source_dir"

# Clean up: remove the temporary directory
rmdir "$temp_dir"

echo "File renaming completed."

##Determine the number of switches in the stack and convert them one by one
#Stacked Switch Config 1
CONFIG1=$(ls /root/.meraki_port_mig/tmp/switch1.txt 2>/dev/null)
SERIAL1=$(ls /root/.meraki_port_mig/tmp/serial1.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_port_mig/tmp/serial1.txt 2>/dev/null)
if [[ "$CONFIG1" == "/root/.meraki_port_mig/tmp/switch1.txt" && "$SERIAL1" == "/root/.meraki_port_mig/tmp/serial1.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 1"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
    \cp -f /root/.meraki_port_mig/tmp/switch1.txt /root/.meraki_port_mig/cisco_config.tmp
    \cp -f /root/.meraki_port_mig/tmp/serial1.txt /root/.meraki_port_mig/serial.txt
    #Move the Uplink ports to a separate file
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet1\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up1.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet1\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up1.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet1\/1\/3/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up1.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet1\/1\/4/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up1.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet1\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up1.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet1\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up1.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet1\/1\/3/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up1.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet1\/1\/4/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up1.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet1\/1\/5/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up1.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet1\/1\/6/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up1.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet1\/1\/7/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up1.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet1\/1\/8/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up1.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/FortyGigabitEthernet1\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up1.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/FortyGigabitEthernet1\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up1.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TwentyFiveGigE1\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up1.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TwentyFiveGigE1\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up1.tmp
    #Remove the uplinks from the file
    sed -i '/GigabitEthernet1\/1\/1/,/!/{//!d;}; /GigabitEthernet1\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet1\/1\/2/,/!/{//!d;}; /GigabitEthernet1\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet1\/1\/3/,/!/{//!d;}; /GigabitEthernet1\/1\/3/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet1\/1\/4/,/!/{//!d;}; /GigabitEthernet1\/1\/4/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet1\/1\/1/,/!/{//!d;}; /TenGigabitEthernet1\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet1\/1\/2/,/!/{//!d;}; /TenGigabitEthernet1\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet1\/1\/3/,/!/{//!d;}; /TenGigabitEthernet1\/1\/3/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet1\/1\/4/,/!/{//!d;}; /TenGigabitEthernet1\/1\/4/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet1\/1\/5/,/!/{//!d;}; /TenGigabitEthernet1\/1\/5/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet1\/1\/6/,/!/{//!d;}; /TenGigabitEthernet1\/1\/6/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet1\/1\/7/,/!/{//!d;}; /TenGigabitEthernet1\/1\/7/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet1\/1\/8/,/!/{//!d;}; /TenGigabitEthernet1\/1\/8/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/FortyGigabitEthernet1\/1\/1/,/!/{//!d;}; /FortyGigabitEthernet1\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/FortyGigabitEthernet1\/1\/2/,/!/{//!d;}; /FortyGigabitEthernet1\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TwentyFiveGigE1\/1\/1/,/!/{//!d;}; /TwentyFiveGigE1\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TwentyFiveGigE1\/1\/2/,/!/{//!d;}; /TwentyFiveGigE1\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/AppGigabitEthernet1\/0\/1/,/!/{//!d;}; /AppGigabitEthernet1\/0\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    unbuffer python3.10 /root/.meraki_port_mig/port_migration.py
    rm -f /root/.meraki_port_mig/cisco_config.tmp
else
    echo " " > /dev/null
fi

#UPLINKS
#SWITCH1
CONFIGUP1=$(ls /root/.meraki_port_mig/cisco_config_up1.tmp 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_port_mig/tmp/serial1.txt 2>/dev/null)
if [[ "$CONFIGUP1" == "/root/.meraki_port_mig/cisco_config_up1.tmp" ]]; then
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    mv /root/.meraki_port_mig/cisco_config_up1.tmp /root/.meraki_port_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_port_mig/port_mig-C9300-NM-8X.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up1.tmp
    echo "${GREEN}Uplink conversion for Switch 1 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

#Stacked Switch Config 2
CONFIG2=$(ls /root/.meraki_port_mig/tmp/switch2.txt 2>/dev/null)
SERIAL2=$(ls /root/.meraki_port_mig/tmp/serial2.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_port_mig/tmp/serial2.txt 2>/dev/null)
if [[ "$CONFIG2" == "/root/.meraki_port_mig/tmp/switch2.txt" && "$SERIAL2" == "/root/.meraki_port_mig/tmp/serial2.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 2"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
    \cp -f /root/.meraki_port_mig/tmp/switch2.txt /root/.meraki_port_mig/cisco_config.tmp
    \cp -f /root/.meraki_port_mig/tmp/serial2.txt /root/.meraki_port_mig/serial.txt
    #Move the Uplink ports to a separate file
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet2\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up2.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet2\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up2.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet2\/1\/3/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up2.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet2\/1\/4/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up2.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet2\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up2.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet2\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up2.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet2\/1\/3/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up2.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet2\/1\/4/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up2.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet2\/1\/5/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up2.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet2\/1\/6/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up2.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet2\/1\/7/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up2.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet2\/1\/8/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up2.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/FortyGigabitEthernet2\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up2.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/FortyGigabitEthernet2\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up2.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TwentyFiveGigE2\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up2.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TwentyFiveGigE2\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up2.tmp
    #Remove the uplinks from the file
    sed -i '/GigabitEthernet2\/1\/1/,/!/{//!d;}; /GigabitEthernet2\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet2\/1\/2/,/!/{//!d;}; /GigabitEthernet2\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet2\/1\/3/,/!/{//!d;}; /GigabitEthernet2\/1\/3/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet2\/1\/4/,/!/{//!d;}; /GigabitEthernet2\/1\/4/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet2\/1\/1/,/!/{//!d;}; /TenGigabitEthernet2\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet2\/1\/2/,/!/{//!d;}; /TenGigabitEthernet2\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet2\/1\/3/,/!/{//!d;}; /TenGigabitEthernet2\/1\/3/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet2\/1\/4/,/!/{//!d;}; /TenGigabitEthernet2\/1\/4/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet2\/1\/5/,/!/{//!d;}; /TenGigabitEthernet2\/1\/5/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet2\/1\/6/,/!/{//!d;}; /TenGigabitEthernet2\/1\/6/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet2\/1\/7/,/!/{//!d;}; /TenGigabitEthernet2\/1\/7/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet2\/1\/8/,/!/{//!d;}; /TenGigabitEthernet2\/1\/8/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/FortyGigabitEthernet2\/1\/1/,/!/{//!d;}; /FortyGigabitEthernet2\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/FortyGigabitEthernet2\/1\/2/,/!/{//!d;}; /FortyGigabitEthernet2\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TwentyFiveGigE2\/1\/1/,/!/{//!d;}; /TwentyFiveGigE2\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TwentyFiveGigE2\/1\/2/,/!/{//!d;}; /TwentyFiveGigE2\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/AppGigabitEthernet2\/0\/1/,/!/{//!d;}; /AppGigabitEthernet2\/0\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    unbuffer python3.10 /root/.meraki_port_mig/port_migration.py
    rm -f /root/.meraki_port_mig/cisco_config.tmp
else
    echo " " > /dev/null
fi

#UPLINKS
#SWITCH2
CONFIGUP2=$(ls /root/.meraki_port_mig/cisco_config_up2.tmp 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_port_mig/tmp/serial2.txt 2>/dev/null)
if [[ "$CONFIGUP2" == "/root/.meraki_port_mig/cisco_config_up2.tmp" ]]; then
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    #sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_port_mig/cisco_config_up2.tmp
    mv /root/.meraki_port_mig/cisco_config_up2.tmp /root/.meraki_port_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_port_mig/port_mig-C9300-NM-8X.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up2.tmp
    echo "${GREEN}Uplink conversion for Switch 2 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

#Stacked Switch Config 3
CONFIG3=$(ls /root/.meraki_port_mig/tmp/switch3.txt 2>/dev/null)
SERIAL3=$(ls /root/.meraki_port_mig/tmp/serial3.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_port_mig/tmp/serial3.txt 2>/dev/null)
if [[ "$CONFIG3" == "/root/.meraki_port_mig/tmp/switch3.txt" && "$SERIAL3" == "/root/.meraki_port_mig/tmp/serial3.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 3"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
    \cp -f /root/.meraki_port_mig/tmp/switch3.txt /root/.meraki_port_mig/cisco_config.tmp
    \cp -f /root/.meraki_port_mig/tmp/serial3.txt /root/.meraki_port_mig/serial.txt
    #Move the Uplink ports to a separate file
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet3\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up3.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet3\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up3.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet3\/1\/3/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up3.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet3\/1\/4/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up3.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet3\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up3.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet3\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up3.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet3\/1\/3/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up3.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet3\/1\/4/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up3.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet3\/1\/5/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up3.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet3\/1\/6/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up3.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet3\/1\/7/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up3.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet3\/1\/8/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up3.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/FortyGigabitEthernet3\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up3.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/FortyGigabitEthernet3\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up3.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TwentyFiveGigE3\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up3.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TwentyFiveGigE3\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up3.tmp
    #Remove the uplinks from the file
    sed -i '/GigabitEthernet3\/1\/1/,/!/{//!d;}; /GigabitEthernet3\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet3\/1\/2/,/!/{//!d;}; /GigabitEthernet3\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet3\/1\/3/,/!/{//!d;}; /GigabitEthernet3\/1\/3/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet3\/1\/4/,/!/{//!d;}; /GigabitEthernet3\/1\/4/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet3\/1\/1/,/!/{//!d;}; /TenGigabitEthernet3\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet3\/1\/2/,/!/{//!d;}; /TenGigabitEthernet3\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet3\/1\/3/,/!/{//!d;}; /TenGigabitEthernet3\/1\/3/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet3\/1\/4/,/!/{//!d;}; /TenGigabitEthernet3\/1\/4/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet3\/1\/5/,/!/{//!d;}; /TenGigabitEthernet3\/1\/5/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet3\/1\/6/,/!/{//!d;}; /TenGigabitEthernet3\/1\/6/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet3\/1\/7/,/!/{//!d;}; /TenGigabitEthernet3\/1\/7/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet3\/1\/8/,/!/{//!d;}; /TenGigabitEthernet3\/1\/8/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/FortyGigabitEthernet3\/1\/1/,/!/{//!d;}; /FortyGigabitEthernet3\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/FortyGigabitEthernet3\/1\/2/,/!/{//!d;}; /FortyGigabitEthernet3\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TwentyFiveGigE3\/1\/1/,/!/{//!d;}; /TwentyFiveGigE3\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TwentyFiveGigE3\/1\/2/,/!/{//!d;}; /TwentyFiveGigE3\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/AppGigabitEthernet3\/0\/1/,/!/{//!d;}; /AppGigabitEthernet3\/0\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    unbuffer python3.10 /root/.meraki_port_mig/port_migration.py
    rm -f /root/.meraki_port_mig/cisco_config.tmp
else
    echo " " > /dev/null
fi

#UPLINKS
#SWITCH3
CONFIGUP3=$(ls /root/.meraki_port_mig/cisco_config_up3.tmp 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_port_mig/tmp/serial3.txt 2>/dev/null)
if [[ "$CONFIGUP3" == "/root/.meraki_port_mig/cisco_config_up3.tmp" ]]; then
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    #sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_port_mig/cisco_config_up3.tmp
    mv /root/.meraki_port_mig/cisco_config_up3.tmp /root/.meraki_port_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_port_mig/port_mig-C9300-NM-8X.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up3.tmp
    echo "${GREEN}Uplink conversion for Switch 3 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi


#Stacked Switch Config 4
CONFIG4=$(ls /root/.meraki_port_mig/tmp/switch4.txt 2>/dev/null)
SERIAL4=$(ls /root/.meraki_port_mig/tmp/serial4.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_port_mig/tmp/serial4.txt 2>/dev/null)
if [[ "$CONFIG4" == "/root/.meraki_port_mig/tmp/switch4.txt" && "$SERIAL4" == "/root/.meraki_port_mig/tmp/serial4.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 4"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
    \cp -f /root/.meraki_port_mig/tmp/switch4.txt /root/.meraki_port_mig/cisco_config.tmp
    \cp -f /root/.meraki_port_mig/tmp/serial4.txt /root/.meraki_port_mig/serial.txt
    #Move the Uplink ports to a separate file
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet4\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up4.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet4\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up4.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet4\/1\/3/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up4.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet4\/1\/4/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up4.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet4\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up4.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet4\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up4.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet4\/1\/3/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up4.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet4\/1\/4/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up4.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet4\/1\/5/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up4.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet4\/1\/6/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up4.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet4\/1\/7/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up4.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet4\/1\/8/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up4.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/FortyGigabitEthernet4\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up4.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/FortyGigabitEthernet4\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up4.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TwentyFiveGigE4\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up4.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TwentyFiveGigE4\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up4.tmp

    #Remove the uplinks from the file
    sed -i '/GigabitEthernet4\/1\/1/,/!/{//!d;}; /GigabitEthernet4\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet4\/1\/2/,/!/{//!d;}; /GigabitEthernet4\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet4\/1\/3/,/!/{//!d;}; /GigabitEthernet4\/1\/3/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet4\/1\/4/,/!/{//!d;}; /GigabitEthernet4\/1\/4/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet4\/1\/1/,/!/{//!d;}; /TenGigabitEthernet4\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet4\/1\/2/,/!/{//!d;}; /TenGigabitEthernet4\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet4\/1\/3/,/!/{//!d;}; /TenGigabitEthernet4\/1\/3/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet4\/1\/4/,/!/{//!d;}; /TenGigabitEthernet4\/1\/4/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet4\/1\/5/,/!/{//!d;}; /TenGigabitEthernet4\/1\/5/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet4\/1\/6/,/!/{//!d;}; /TenGigabitEthernet4\/1\/6/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet4\/1\/7/,/!/{//!d;}; /TenGigabitEthernet4\/1\/7/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet4\/1\/8/,/!/{//!d;}; /TenGigabitEthernet4\/1\/8/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/FortyGigabitEthernet4\/1\/1/,/!/{//!d;}; /FortyGigabitEthernet4\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/FortyGigabitEthernet4\/1\/2/,/!/{//!d;}; /FortyGigabitEthernet4\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TwentyFiveGigE4\/1\/1/,/!/{//!d;}; /TwentyFiveGigE4\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TwentyFiveGigE4\/1\/2/,/!/{//!d;}; /TwentyFiveGigE4\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/AppGigabitEthernet4\/0\/1/,/!/{//!d;}; /AppGigabitEthernet4\/0\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    unbuffer python3.10 /root/.meraki_port_mig/port_migration.py
    rm -f /root/.meraki_port_mig/cisco_config.tmp
else
    echo " " > /dev/null
fi

#UPLINKS
#SWITCH4
CONFIGUP4=$(ls /root/.meraki_port_mig/cisco_config_up4.tmp 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_port_mig/tmp/serial4.txt 2>/dev/null)
if [[ "$CONFIGUP4" == "/root/.meraki_port_mig/cisco_config_up4.tmp" ]]; then
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    #sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_port_mig/cisco_config_up4.tmp
    mv /root/.meraki_port_mig/cisco_config_up4.tmp /root/.meraki_port_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_port_mig/port_mig-C9300-NM-8X.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up4.tmp
    echo "${GREEN}Uplink conversion for Switch 4 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

#Stacked Switch Config 5
CONFIG5=$(ls /root/.meraki_port_mig/tmp/switch5.txt 2>/dev/null)
SERIAL5=$(ls /root/.meraki_port_mig/tmp/serial5.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_port_mig/tmp/serial5.txt 2>/dev/null)
if [[ "$CONFIG5" == "/root/.meraki_port_mig/tmp/switch5.txt" && "$SERIAL5" == "/root/.meraki_port_mig/tmp/serial5.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 5"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
    \cp -f /root/.meraki_port_mig/tmp/switch5.txt /root/.meraki_port_mig/cisco_config.tmp
    \cp -f /root/.meraki_port_mig/tmp/serial5.txt /root/.meraki_port_mig/serial.txt
    #Move the Uplink ports to a separate file
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet5\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up5.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet5\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up5.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet5\/1\/3/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up5.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet5\/1\/4/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up5.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet5\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up5.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet5\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up5.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet5\/1\/3/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up5.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet5\/1\/4/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up5.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet5\/1\/5/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up5.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet5\/1\/6/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up5.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet5\/1\/7/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up5.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet5\/1\/8/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up5.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/FortyGigabitEthernet5\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up5.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/FortyGigabitEthernet5\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up5.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TwentyFiveGigE5\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up5.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TwentyFiveGigE5\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up5.tmp
    #Remove the uplinks from the file
    sed -i '/GigabitEthernet5\/1\/1/,/!/{//!d;}; /GigabitEthernet5\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet5\/1\/2/,/!/{//!d;}; /GigabitEthernet5\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet5\/1\/3/,/!/{//!d;}; /GigabitEthernet5\/1\/3/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet5\/1\/4/,/!/{//!d;}; /GigabitEthernet5\/1\/4/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet5\/1\/1/,/!/{//!d;}; /TenGigabitEthernet5\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet5\/1\/2/,/!/{//!d;}; /TenGigabitEthernet5\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet5\/1\/3/,/!/{//!d;}; /TenGigabitEthernet5\/1\/3/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet5\/1\/4/,/!/{//!d;}; /TenGigabitEthernet5\/1\/4/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet5\/1\/5/,/!/{//!d;}; /TenGigabitEthernet5\/1\/5/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet5\/1\/6/,/!/{//!d;}; /TenGigabitEthernet5\/1\/6/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet5\/1\/7/,/!/{//!d;}; /TenGigabitEthernet5\/1\/7/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet5\/1\/8/,/!/{//!d;}; /TenGigabitEthernet5\/1\/8/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/FortyGigabitEthernet5\/1\/1/,/!/{//!d;}; /FortyGigabitEthernet5\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/FortyGigabitEthernet5\/1\/2/,/!/{//!d;}; /FortyGigabitEthernet5\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TwentyFiveGigE5\/1\/1/,/!/{//!d;}; /TwentyFiveGigE5\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TwentyFiveGigE5\/1\/2/,/!/{//!d;}; /TwentyFiveGigE5\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/AppGigabitEthernet5\/0\/1/,/!/{//!d;}; /AppGigabitEthernet5\/0\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    unbuffer python3.10 /root/.meraki_port_mig/port_migration.py
    rm -f /root/.meraki_port_mig/cisco_config.tmp
else
    echo " " > /dev/null
fi

#UPLINKS
#SWITCH5
CONFIGUP5=$(ls /root/.meraki_port_mig/cisco_config_up5.tmp 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_port_mig/tmp/serial5.txt 2>/dev/null)
if [[ "$CONFIGUP5" == "/root/.meraki_port_mig/cisco_config_up5.tmp" ]]; then
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    #sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_port_mig/cisco_config_up5.tmp
    mv /root/.meraki_port_mig/cisco_config_up5.tmp /root/.meraki_port_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_port_mig/port_mig-C9300-NM-8X.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up5.tmp
    echo "${GREEN}Uplink conversion for Switch 5 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

#Stacked Switch Config 6
CONFIG6=$(ls /root/.meraki_port_mig/tmp/switch6.txt 2>/dev/null)
SERIAL6=$(ls /root/.meraki_port_mig/tmp/serial6.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_port_mig/tmp/serial6.txt 2>/dev/null)
if [[ "$CONFIG6" == "/root/.meraki_port_mig/tmp/switch6.txt" && "$SERIAL6" == "/root/.meraki_port_mig/tmp/serial6.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 6"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
    \cp -f /root/.meraki_port_mig/tmp/switch6.txt /root/.meraki_port_mig/cisco_config.tmp
    \cp -f /root/.meraki_port_mig/tmp/serial6.txt /root/.meraki_port_mig/serial.txt
    #Move the Uplink ports to a separate file
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet6\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up6.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet6\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up6.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet6\/1\/3/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up6.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet6\/1\/4/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up6.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet6\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up6.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet6\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up6.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet6\/1\/3/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up6.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet6\/1\/4/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up6.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet6\/1\/5/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up6.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet6\/1\/6/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up6.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet6\/1\/7/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up6.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet6\/1\/8/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up6.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/FortyGigabitEthernet6\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up6.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/FortyGigabitEthernet6\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up6.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TwentyFiveGigE6\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up6.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TwentyFiveGigE6\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up6.tmp
    #Remove the uplinks from the file
    sed -i '/GigabitEthernet6\/1\/1/,/!/{//!d;}; /GigabitEthernet6\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet6\/1\/2/,/!/{//!d;}; /GigabitEthernet6\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet6\/1\/3/,/!/{//!d;}; /GigabitEthernet6\/1\/3/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet6\/1\/4/,/!/{//!d;}; /GigabitEthernet6\/1\/4/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet6\/1\/1/,/!/{//!d;}; /TenGigabitEthernet6\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet6\/1\/2/,/!/{//!d;}; /TenGigabitEthernet6\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet6\/1\/3/,/!/{//!d;}; /TenGigabitEthernet6\/1\/3/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet6\/1\/4/,/!/{//!d;}; /TenGigabitEthernet6\/1\/4/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet6\/1\/5/,/!/{//!d;}; /TenGigabitEthernet6\/1\/5/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet6\/1\/6/,/!/{//!d;}; /TenGigabitEthernet6\/1\/6/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet6\/1\/7/,/!/{//!d;}; /TenGigabitEthernet6\/1\/7/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet6\/1\/8/,/!/{//!d;}; /TenGigabitEthernet6\/1\/8/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/FortyGigabitEthernet6\/1\/1/,/!/{//!d;}; /FortyGigabitEthernet6\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/FortyGigabitEthernet6\/1\/2/,/!/{//!d;}; /FortyGigabitEthernet6\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TwentyFiveGigE6\/1\/1/,/!/{//!d;}; /TwentyFiveGigE6\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TwentyFiveGigE6\/1\/2/,/!/{//!d;}; /TwentyFiveGigE6\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/AppGigabitEthernet6\/0\/1/,/!/{//!d;}; /AppGigabitEthernet6\/0\/1/d' /root/.meraki_port_mig/cisco_config.tmp

    unbuffer python3.10 /root/.meraki_port_mig/port_migration.py
    rm -f /root/.meraki_port_mig/cisco_config.tmp
else
    echo " " > /dev/null
fi

#UPLINKS
#SWITCH6
CONFIGUP6=$(ls /root/.meraki_port_mig/cisco_config_up6.tmp 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_port_mig/tmp/serial6.txt 2>/dev/null)
if [[ "$CONFIGUP6" == "/root/.meraki_port_mig/cisco_config_up6.tmp" ]]; then
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    #sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_port_mig/cisco_config_up6.tmp
    mv /root/.meraki_port_mig/cisco_config_up2.tmp /root/.meraki_port_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_port_mig/port_mig-C9300-NM-8X.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up6.tmp
    echo "${GREEN}Uplink conversion for Switch 6 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

#Stacked Switch Config 7
CONFIG7=$(ls /root/.meraki_port_mig/tmp/switch7.txt 2>/dev/null)
SERIAL7=$(ls /root/.meraki_port_mig/tmp/serial7.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_port_mig/tmp/serial7.txt 2>/dev/null)
if [[ "$CONFIG7" == "/root/.meraki_port_mig/tmp/switch7.txt" && "$SERIAL7" == "/root/.meraki_port_mig/tmp/serial7.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 7"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
    \cp -f /root/.meraki_port_mig/tmp/switch7.txt /root/.meraki_port_mig/cisco_config.tmp
    \cp -f /root/.meraki_port_mig/tmp/serial7.txt /root/.meraki_port_mig/serial.txt
    #Move the Uplink ports to a separate file
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet7\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up7.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet7\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up7.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet7\/1\/3/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up7.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet7\/1\/4/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up7.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet7\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up7.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet7\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up7.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet7\/1\/3/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up7.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet7\/1\/4/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up7.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet7\/1\/5/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up7.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet7\/1\/6/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up7.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet7\/1\/7/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up7.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet7\/1\/8/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up7.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/FortyGigabitEthernet7\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up7.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/FortyGigabitEthernet7\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up7.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TwentyFiveGigE7\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up7.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TwentyFiveGigE7\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up7.tmp
    #Remove the uplinks from the file
    sed -i '/GigabitEthernet7\/1\/1/,/!/{//!d;}; /GigabitEthernet7\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet7\/1\/2/,/!/{//!d;}; /GigabitEthernet7\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet7\/1\/3/,/!/{//!d;}; /GigabitEthernet7\/1\/3/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet7\/1\/4/,/!/{//!d;}; /GigabitEthernet7\/1\/4/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet7\/1\/1/,/!/{//!d;}; /TenGigabitEthernet7\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet7\/1\/2/,/!/{//!d;}; /TenGigabitEthernet7\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet7\/1\/3/,/!/{//!d;}; /TenGigabitEthernet7\/1\/3/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet7\/1\/4/,/!/{//!d;}; /TenGigabitEthernet7\/1\/4/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet7\/1\/5/,/!/{//!d;}; /TenGigabitEthernet7\/1\/5/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet7\/1\/6/,/!/{//!d;}; /TenGigabitEthernet7\/1\/6/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet7\/1\/7/,/!/{//!d;}; /TenGigabitEthernet7\/1\/7/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet7\/1\/8/,/!/{//!d;}; /TenGigabitEthernet7\/1\/8/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/FortyGigabitEthernet7\/1\/1/,/!/{//!d;}; /FortyGigabitEthernet7\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/FortyGigabitEthernet7\/1\/2/,/!/{//!d;}; /FortyGigabitEthernet7\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TwentyFiveGigE7\/1\/1/,/!/{//!d;}; /TwentyFiveGigE7\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TwentyFiveGigE7\/1\/2/,/!/{//!d;}; /TwentyFiveGigE7\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/AppGigabitEthernet7\/0\/1/,/!/{//!d;}; /AppGigabitEthernet7\/0\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    unbuffer python3.10 /root/.meraki_port_mig/port_migration.py
    rm -f /root/.meraki_port_mig/cisco_config.tmp
else
    echo " " > /dev/null
fi

#UPLINKS
#SWITCH7
CONFIGUP7=$(ls /root/.meraki_port_mig/cisco_config_up7.tmp 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_port_mig/tmp/serial7.txt 2>/dev/null)
if [[ "$CONFIGUP7" == "/root/.meraki_port_mig/cisco_config_up7.tmp" ]]; then
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    #sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_port_mig/cisco_config_up7.tmp
    mv /root/.meraki_port_mig/cisco_config_up7.tmp /root/.meraki_port_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_port_mig/port_mig-C9300-NM-8X.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up7.tmp
    echo "${GREEN}Uplink conversion for Switch 7 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi
#Stacked Switch Config 8
CONFIG8=$(ls /root/.meraki_port_mig/tmp/switch8.txt 2>/dev/null)
SERIAL8=$(ls /root/.meraki_port_mig/tmp/serial8.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_port_mig/tmp/serial8.txt 2>/dev/null)
if [[ "$CONFIG8" == "/root/.meraki_port_mig/tmp/switch8.txt" && "$SERIAL8" == "/root/.meraki_port_mig/tmp/serial8.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 8"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
    \cp -f /root/.meraki_port_mig/tmp/switch8.txt /root/.meraki_port_mig/cisco_config.tmp
    \cp -f /root/.meraki_port_mig/tmp/serial8.txt /root/.meraki_port_mig/serial.txt
    #Move the Uplink ports to a separate file
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet8\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up8.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet8\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up8.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet8\/1\/3/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up8.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet8\/1\/4/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up8.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet8\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up8.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet8\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up8.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet8\/1\/3/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up8.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet8\/1\/4/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up8.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet8\/1\/5/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up8.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet8\/1\/6/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up8.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet8\/1\/7/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up8.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet8\/1\/8/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up8.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/FortyGigabitEthernet8\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up8.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/FortyGigabitEthernet8\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up8.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TwentyFiveGigE8\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up8.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TwentyFiveGigE8\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up8.tmp
    #Remove the uplinks from the file
    sed -i '/GigabitEthernet8\/1\/1/,/!/{//!d;}; /GigabitEthernet8\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet8\/1\/2/,/!/{//!d;}; /GigabitEthernet8\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet8\/1\/3/,/!/{//!d;}; /GigabitEthernet8\/1\/3/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet8\/1\/4/,/!/{//!d;}; /GigabitEthernet8\/1\/4/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet8\/1\/1/,/!/{//!d;}; /TenGigabitEthernet8\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet8\/1\/2/,/!/{//!d;}; /TenGigabitEthernet8\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet8\/1\/3/,/!/{//!d;}; /TenGigabitEthernet8\/1\/3/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet8\/1\/4/,/!/{//!d;}; /TenGigabitEthernet8\/1\/4/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet8\/1\/5/,/!/{//!d;}; /TenGigabitEthernet8\/1\/5/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet8\/1\/6/,/!/{//!d;}; /TenGigabitEthernet8\/1\/6/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet8\/1\/7/,/!/{//!d;}; /TenGigabitEthernet8\/1\/7/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet8\/1\/8/,/!/{//!d;}; /TenGigabitEthernet8\/1\/8/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/FortyGigabitEthernet8\/1\/1/,/!/{//!d;}; /FortyGigabitEthernet8\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/FortyGigabitEthernet8\/1\/2/,/!/{//!d;}; /FortyGigabitEthernet8\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TwentyFiveGigE8\/1\/1/,/!/{//!d;}; /TwentyFiveGigE8\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TwentyFiveGigE8\/1\/2/,/!/{//!d;}; /TwentyFiveGigE8\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/AppGigabitEthernet8\/0\/1/,/!/{//!d;}; /AppGigabitEthernet8\/0\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    unbuffer python3.10 /root/.meraki_port_mig/port_migration.py
    rm -f /root/.meraki_port_mig/cisco_config.tmp
else
    echo " " > /dev/null
fi

#UPLINKS
#SWITCH8
CONFIGUP8=$(ls /root/.meraki_port_mig/cisco_config_up8.tmp 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_port_mig/tmp/serial8.txt 2>/dev/null)
if [[ "$CONFIGUP8" == "/root/.meraki_port_mig/cisco_config_up8.tmp" ]]; then
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    #sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_port_mig/cisco_config_up8.tmp
    mv /root/.meraki_port_mig/cisco_config_up8.tmp /root/.meraki_port_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_port_mig/port_mig-C9300-NM-8X.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up8.tmp
    echo "${GREEN}Uplink conversion for Switch 8 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

#Stacked Switch Config 9
CONFIG9=$(ls /root/.meraki_port_mig/tmp/switch9.txt 2>/dev/null)
SERIAL9=$(ls /root/.meraki_port_mig/tmp/serial9.txt 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_port_mig/tmp/serial9.txt 2>/dev/null)
if [[ "$CONFIG9" == "/root/.meraki_port_mig/tmp/switch9.txt" && "$SERIAL9" == "/root/.meraki_port_mig/tmp/serial9.txt" ]]; then
    echo "${GREEN}${IP}-Found switch 9"
    echo "New CloudID is:${CATSERIAL}${TEXTRESET}"
    \cp -f /root/.meraki_port_mig/tmp/switch9.txt /root/.meraki_port_mig/cisco_config.tmp
    \cp -f /root/.meraki_port_mig/tmp/serial9.txt /root/.meraki_port_mig/serial.txt
    #Move the Uplink ports to a separate file
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet9\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up9.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet9\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up9.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet9\/1\/3/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up9.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/GigabitEthernet9\/1\/4/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up9.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet9\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up9.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet9\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up9.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet9\/1\/3/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up9.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet9\/1\/4/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up9.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet9\/1\/5/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up9.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet9\/1\/6/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up9.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet9\/1\/7/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up9.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TenGigabitEthernet9\/1\/8/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up9.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/FortyGigabitEthernet9\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up9.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/FortyGigabitEthernet9\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up9.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TwentyFiveGigE9\/1\/1/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up9.tmp
    cat /root/.meraki_port_mig/cisco_config.tmp | awk '/TwentyFiveGigE9\/1\/2/ {found=1} found {print} /!/{if (found) exit}' >>/root/.meraki_port_mig/cisco_config_up9.tmp
    #Remove the uplinks from the file
    sed -i '/GigabitEthernet9\/1\/1/,/!/{//!d;}; /GigabitEthernet9\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet9\/1\/2/,/!/{//!d;}; /GigabitEthernet9\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet9\/1\/3/,/!/{//!d;}; /GigabitEthernet9\/1\/3/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/GigabitEthernet9\/1\/4/,/!/{//!d;}; /GigabitEthernet9\/1\/4/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet9\/1\/1/,/!/{//!d;}; /TenGigabitEthernet9\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet9\/1\/2/,/!/{//!d;}; /TenGigabitEthernet9\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet9\/1\/3/,/!/{//!d;}; /TenGigabitEthernet9\/1\/3/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet9\/1\/4/,/!/{//!d;}; /TenGigabitEthernet9\/1\/4/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet9\/1\/5/,/!/{//!d;}; /TenGigabitEthernet9\/1\/5/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet9\/1\/6/,/!/{//!d;}; /TenGigabitEthernet9\/1\/6/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet9\/1\/7/,/!/{//!d;}; /TenGigabitEthernet9\/1\/7/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TenGigabitEthernet9\/1\/8/,/!/{//!d;}; /TenGigabitEthernet9\/1\/8/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/FortyGigabitEthernet9\/1\/1/,/!/{//!d;}; /FortyGigabitEthernet9\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/FortyGigabitEthernet9\/1\/2/,/!/{//!d;}; /FortyGigabitEthernet9\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TwentyFiveGigE9\/1\/1/,/!/{//!d;}; /TwentyFiveGigE9\/1\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/TwentyFiveGigE9\/1\/2/,/!/{//!d;}; /TwentyFiveGigE9\/1\/2/d' /root/.meraki_port_mig/cisco_config.tmp
    sed -i '/AppGigabitEthernet9\/0\/1/,/!/{//!d;}; /AppGigabitEthernet9\/0\/1/d' /root/.meraki_port_mig/cisco_config.tmp
    unbuffer python3.10 /root/.meraki_port_mig/port_migration.py
    rm -f /root/.meraki_port_mig/cisco_config.tmp
else
    echo " " > /dev/null
fi

#UPLINKS
#SWITCH9
CONFIGUP9=$(ls /root/.meraki_port_mig/cisco_config_up9.tmp 2>/dev/null)
CATSERIAL=$(cat /root/.meraki_port_mig/tmp/serial9.txt 2>/dev/null)
if [[ "$CONFIGUP9" == "/root/.meraki_port_mig/cisco_config_up9.tmp" ]]; then
    echo "${GREEN}Migrating Gigabit/TenGigabit Information to Uplink${TEXTRESET}"
    #Remove unneeded interfaces
    #sed -i '/interface FortyGigabitEthernet1\/1\/1/,$d' /root/.meraki_port_mig/cisco_config_up9.tmp
    mv /root/.meraki_port_mig/cisco_config_up9.tmp /root/.meraki_port_mig/cisco_config_up.tmp
    python3.10 /root/.meraki_port_mig/port_mig-C9300-NM-8X.py
    rm -f /root/.meraki_mig/cisco_config_up.tmp
    rm -f /root/.meraki_mig/cisco_config_up9.tmp
    echo "${GREEN}Uplink conversion for Switch 9 (${IP} to ${CATSERIAL}) Complete${TEXTRESET}"
    echo " "
else
    echo " " > /dev/null
fi

rm -f /root/.meraki_port_mig/serial.txt
rm -f /root/.meraki_port_mig/cisco_config.tmp
rm -f /root/.meraki_port_mig/tmp/*
echo "${IP}-Conversion Script Complete"

sleep 1
