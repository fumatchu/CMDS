#!/bin/bash
#This file takes the SWitch stack format and breaks it down to individual files.
#After the individual files are borken down it then runs the parse command

# Define the input file path
input_file="/root/port_migration/staging/port_merge.csv"  # Replace with your actual file path

mkdir -p /root/.meraki_port_mig/tmp

# Define a base directory for the output files
output_dir="/root/.meraki_port_mig/tmp"  # Replace with your desired output directory

# Regular expression pattern for matching an IP address
ip_regex='([0-9]{1,3}\.){3}[0-9]{1,3}'

# Initialize a line counter
line_counter=0

# Variables to store lines
line1=""
line2=""

# Ensure output directory exists
mkdir -p "$output_dir"

# Read the input file line by line
while IFS= read -r line; do
  if (( line_counter % 2 == 0 )); then
    # Store the first line of the pair
    line1="$line"
  else
    # Store the second line of the pair
    line2="$line"

    # Attempt to extract IP address from the first and second lines
    if [[ "$line1" =~ $ip_regex ]]; then
      ip_address="${BASH_REMATCH[0]}"
    elif [[ "$line2" =~ $ip_regex ]]; then
      ip_address="${BASH_REMATCH[0]}"
    else
      ip_address="unknown_ip"
    fi

    # Define the output file name using the extracted IP address
    output_file="${output_dir}/output_${ip_address}_${line_counter}_port_mig.txt"

    # Write the pair of lines to the output file
    echo "$line1" >> "$output_file"
    echo "$line2" >> "$output_file"
  fi

  # Increment the line counter
  ((line_counter++))

done < "$input_file"

echo "File splitting complete. Check the output files in the specified directory."


#Parse each file created and run parse switch against it

# Define the directory containing the files
input_dir="/root/.meraki_port_mig/tmp"  # Replace with your actual directory path

# Define the file to be updated
config_file="/root/.meraki_port_mig/parse_switch.sh"

# Iterate over each file in the directory
for file in "$input_dir"/*; do
  # Ensure the file is not empty and is a regular file
  if [[ -f "$file" && -s "$file" ]]; then
    # Read the first two lines of the file
    {
      read -r line1
      read -r line2
    } < "$file"

    # Extract IP address and number from the first line
    if [[ "$line1" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3},([0-9]+)$ ]]; then
      ip1="${BASH_REMATCH[0]%,*}"
      useroption1="${BASH_REMATCH[2]}"

      # Update the config file using sed
      sed -i "s/^IP1=.*/IP1=${ip1}/" "$config_file"
      sed -i "s/^USEROPTION1=.*/USEROPTION1=${useroption1}/" "$config_file"
      sed -i "s/^AIP=.*/AIP=${ip1}/" "$config_file"
    fi

    # Extract IP address and number from the second line
    if [[ "$line2" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3},([0-9]+)$ ]]; then
      ip2="${BASH_REMATCH[0]%,*}"
      useroption2="${BASH_REMATCH[2]}"

      # Update the config file using sed
      sed -i "s/^IP2=.*/IP2=${ip2}/" "$config_file"
      sed -i "s/^USEROPTION2=.*/USEROPTION2=${useroption2}/" "$config_file"
      sed -i "s/^AIP=.*/AIP=${ip2}/" "$config_file"
      /root/.meraki_port_mig/parse_switch.sh
      /root/.meraki_port_mig/merge_switches_nfe_end.sh

      sed -i 's/^IP1=.*$/IP1=/' "$config_file"
      sed -i 's/^IP2=.*$/IP2=/' "$config_file"
      sed -i 's/^AIP=.*$/AIP=/' "$config_file"
      sed -i 's/^USEROPTION1=.*$/USEROPTION1=/' "$config_file"
      sed -i 's/^USEROPTION2=.*$/USEROPTION2=/' "$config_file"
    
     fi
  fi
done

echo "Configuration files have been updated based on the input files in the directory."
echo "Removing TMP files"
rm -f /root/.meraki_port_mig/tmp/*