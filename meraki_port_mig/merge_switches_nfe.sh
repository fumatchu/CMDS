NFE

#!/bin/bash
#Check if the top line has the headers

# Define the input file
input_file="/root/port_migration/staging/switch_collection.csv"  # Replace with your actual file path

# Check if the first line contains "MERGE-IPADDRESS" and remove it if it does
sed -i '1{/MERGE-IPADDR/d;}' "$input_file"

# Define the input CSV file
input_file="/root/port_migration/staging/switch_collection.csv"  # Replace with your actual CSV file path

# Define the script to update
config_file="/root/.meraki_port_mig/parse_switch.sh"

# Regular expression for matching an IP address
ip_regex='([0-9]{1,3}\.){3}[0-9]{1,3}'

# Read the CSV file line by line
while IFS= read -r line; do
  # Check if the line contains "MERGE-" followed by an IP address
  if [[ "$line" =~ MERGE- ]]; then
    # Extract IP addresses and numbers using awk
    result=$(echo "$line" | awk -F',' -v ipregex="$ip_regex" '
    {
      entry_count = 0
      for (i = 1; i <= NF; i++) {
        if ($i ~ "MERGE-"ipregex) {
          entry_count++

          # Extract the IP address using regex
          match($i, ipregex, ip)
          ip_address = ip[0]

          # Extract the number after the last hyphen
          split($i, parts, "-")
          last_number = parts[length(parts)]

          # Assign to variables based on entry count
          if (entry_count == 1) {
            ip1 = ip_address
            useroption1 = last_number
          } else if (entry_count == 2) {
            ip2 = ip_address
            useroption2 = last_number
          }
        }
      }
      # Print the extracted values in a format that can be used as shell variables
      if (entry_count == 2) {
        print ip1, useroption1, ip2, useroption2
      }
    }')

    # Read the result into shell variables
    read IP1 USEROPTION1 IP2 USEROPTION2 <<< "$result"

    # Display the variables
    echo "IP1=${IP1}, USEROPTION1=${USEROPTION1}, IP2=${IP2}, USEROPTION2=${USEROPTION2}"

    # Update the parse_switch.sh file
    sed -i "s/^IP1=.*/IP1=${IP1}/" "$config_file"
    sed -i "s/^USEROPTION1=.*/USEROPTION1=${USEROPTION1}/" "$config_file"
    sed -i "s/^AIP=.*/AIP=${IP1}/" "$config_file"

    sed -i "s/^IP2=.*/IP2=${IP2}/" "$config_file"
    sed -i "s/^USEROPTION2=.*/USEROPTION2=${USEROPTION2}/" "$config_file"
    sed -i "s/^AIP=.*/AIP=${IP2}/" "$config_file"
    dos2unix /root/.meraki_port_mig/parse_switch.sh
    # Execute the updated script
    /root/.meraki_port_mig/parse_switch.sh
  fi
done < "$input_file"


IP1=$(cat /root/.meraki_port_mig/parse_switch.sh | grep IP1= | cut -c5-)
IP2=$(cat /root/.meraki_port_mig/parse_switch.sh | grep IP2= | cut -c5-)
SWITCH1=$(cat /root/.meraki_port_mig/parse_switch.sh | grep USEROPTION1 | cut -c13-)
SWITCH2=$(cat /root/.meraki_port_mig/parse_switch.sh | grep USEROPTION2 | cut -c13-)
#We need to get the switches we selected

mkdir -p /root/.meraki_port_mig/staging/active
\cp /root/.meraki_port_mig/staging/${IP1}switch${SWITCH1}.txt /root/.meraki_port_mig/staging/active
\cp /root/.meraki_port_mig/staging/${IP2}switch${SWITCH2}.txt /root/.meraki_port_mig/staging/active
echo "Moved files to Active staging"
sleep 1
echo "Merging ${IP1}switch${SWITCH1}.txt and ${IP2}switch${SWITCH2}.txt"

#Remove the Uplink ports of switch one and place them in a temp file
# Define the input and temporary output files
input_file="/root/.meraki_port_mig/staging/active/${IP1}switch${SWITCH1}.txt"  # Replace with your actual switch config file path
tmp_file="/root/.meraki_port_mig/staging/active/tmp_config.txt"  # The temporary file to store extracted configurations

# Use awk to find and extract the desired port configurations
awk '
/^interface .*\/1\/[0-9]+/ {
    capture = 1
}
capture {
    print
    if (/^!/) {
        capture = 0
    }
}
' "$input_file" > "$tmp_file"

echo "Port configurations with middle number 1 have been moved to $tmp_file"

#Remove all the uplink ports from the configs since we have moved the uplink ports we want to keep
#Switch1
# Define the input and output files
input_file="/root/.meraki_port_mig/staging/active/${IP1}switch${SWITCH1}.txt"  # Replace with your actual switch config file path
output_file="/root/.meraki_port_mig/staging/active/${IP1}switch${SWITCH1}tmp.txt"  # The file to save the modified configuration

# Use awk to process the file and remove the specified port configurations
awk '
/^interface .*\/1\/[0-9]+/ {
    capture = 1
}
!capture { print }
capture && /^!/ {
    capture = 0
}
' "$input_file" > "$output_file"
mv -v /root/.meraki_port_mig/staging/active/${IP1}switch${SWITCH1}tmp.txt /root/.meraki_port_mig/staging/active/${IP1}switch${SWITCH1}.txt
echo "Port configurations with middle number 1 have been removed and saved to $output_file"


#Remove all the uplink ports from the configs since we have moved the uplink ports we want to keep
#Switch2

# Define the input and output files
input_file="/root/.meraki_port_mig/staging/active/${IP2}switch${SWITCH2}.txt"  # Replace with your actual switch config file path
output_file="/root/.meraki_port_mig/staging/active/${IP2}switch${SWITCH2}tmp.txt"  # The file to save the modified configuration

# Use awk to process the file and remove the specified port configurations
awk '
/^interface .*\/1\/[0-9]+/ {
    capture = 1
}
!capture { print }
capture && /^!/ {
    capture = 0
}
' "$input_file" > "$output_file"
mv -v /root/.meraki_port_mig/staging/active/${IP2}switch${SWITCH2}tmp.txt /root/.meraki_port_mig/staging/active/${IP2}switch${SWITCH2}.txt
echo "Port configurations with middle number 1 have been removed and saved to $output_file"



#Take the Downlink ports and merge them
# Define the input configuration files
config1="/root/.meraki_port_mig/staging/active/${IP1}switch${SWITCH1}.txt"  # Replace with your first switch config file
config2="/root/.meraki_port_mig/staging/active/${IP2}switch${SWITCH2}.txt"  # Replace with your second switch config file

# Define the output configuration file
output_config="/root/.meraki_port_mig/staging/active/merged_48_port_config.txt"

# Function to find the first module number in a configuration file
find_first_module() {
  awk '/^interface / && /GigabitEthernet/ {
    if (match($2, /[0-9]+\/[0-9]+\/[0-9]+/, arr)) {
      split(arr[0], parts, "/")
      print parts[1]  # Return the first part which is the module number
      exit
    }
  }' "$1"
}

# Function to renumber ports in the second config, starting from 25
renumber_ports() {
  awk -v old_mod="$1" -v new_mod="$2" '
  BEGIN {
    port_offset = 24  # Offset for the second switch to start from port 25
  }
  /^interface / {
    if ($2 ~ "GigabitEthernet" old_mod "/0/") {
      # Extract the port number
      split($2, a, "/")
      # Calculate the new port number
      new_port = a[3] + port_offset
      # Reconstruct the interface name with the new module and port number
      $2 = "GigabitEthernet" new_mod "/0/" new_port
    }
  }
  { print }
  ' "$3"
}

# Find the module numbers
first_config_module=$(find_first_module "$config1")
second_config_module=$(find_first_module "$config2")

# Start with the configuration of the first switch
cat "$config1" > "$output_config"

# Renumber ports for the second switch and append to the output file
renumber_ports "$second_config_module" "$first_config_module" "$config2" >> "$output_config"

#Insert the uplink ports from switch 1 back into the config
cat /root/.meraki_port_mig/staging/active/tmp_config.txt >> /root/.meraki_port_mig/staging/active/merged_48_port_config.txt

#Clean up the file
# Define the input and output files
input_file="/root/.meraki_port_mig/staging/active/merged_48_port_config.txt"  # Replace with your actual switch config file path
output_file="/root/.meraki_port_mig/staging/active/merged_48_port_config.tmp.txt"  # The file to save the modified configuration

# Use awk to process the file and remove the specified configurations
awk '
BEGIN {
    count_0_25 = 0
    capture = 0
}
/^interface .*0\/25/ {
    count_0_25++
    if (count_0_25 == 2) {
        capture = 1
    }
}
/^interface AppGigabitEthernet/ {
    capture = 1
}
!capture { print }
capture && /^!/ {
    capture = 0
}
' "$input_file" > "$output_file"

echo "Specified configurations have been removed and saved to $output_file"
echo "Merged configuration saved to $output_config"

mv -f /root/.meraki_port_mig/staging/active/merged_48_port_config.tmp.txt /root/.meraki_port_mig/staging/active/${IP1}.merged


#Clean up the original file
#Remove the First switch config from the real config
# Ensure SWITCH1 variable is set
if [ -z "$SWITCH1" ]; then
  echo "SWITCH11 variable is not set. Please set USEROPTION1 before running the script."
  exit 1
fi

# Define the input configuration file
input_file="/var/lib/tftpboot/port_switch/${IP1}"  # Replace with your actual switch config file path

# Use sed to remove the desired configurations
sed -i "/^interface .*${SWITCH1}\/[01]\/[0-9]\+/,/^!/d" "$input_file"

echo "Removed configurations for ports starting with ${SWITCH1}/0/* and ${SWITCH1}/1/* from $input_file."

#Remove the Second switch config from the real config

# Ensure SWITCH2 variable is set
if [ -z "$SWITCH2" ]; then
  echo "SWITCH2 variable is not set. Please set SWITCH2 before running the script."
  exit 1
fi

# Define the input configuration file
input_file="/var/lib/tftpboot/port_switch/${IP1}"  # Replace with your actual switch config file path

# Use sed to remove the desired configurations
sed -i "/^interface .*${SWITCH2}\/[01]\/[0-9]\+/,/^!/d" "$input_file"

echo "Removed configurations for ports starting with ${SWITCH2}/0/* and ${SWITCH2}/1/* from $input_file."

#Insert the merged config into the real config
# Define the input configuration file and the file to insert
config_file="/var/lib/tftpboot/port_switch/${IP1}"  # Replace with your actual switch config file path
insert_file="/root/.meraki_port_mig/staging/active/${IP1}.merged" # Replace with the file you want to insert

# Use awk to insert the content of insert_file above the line containing "interface Vlan1"
awk -v insert_file="$insert_file" '
BEGIN {
    # Read the content of the file to be inserted
    while ((getline line < insert_file) > 0) {
        insert_lines = insert_lines line "\n"
    }
    close(insert_file)
}
/^interface Vlan1/ {
    # Before printing "interface Vlan1", print the inserted content and a "!"
    print insert_lines "!"
}
{ print }
' "$config_file" > temp_config.txt

# Move the modified content back to the original config file
mv temp_config.txt "$config_file"

echo "Inserted content above 'interface Vlan1' in $config_file."


#Clean up Directories
find /root/.meraki_port_mig/staging -type f -exec rm -f {} +