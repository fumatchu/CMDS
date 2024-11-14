#!/bin/bash
rm -f /root/.meraki_port_mig/staging/switch_collection.csv
mkdir -p /root/.meraki_port_mig/staging
\cp -r /root/port_migration/staging/switch_collection.csv /root/.meraki_port_mig/staging

# Define the input file
input_file="/root/.meraki_port_mig/staging/switch_collection.csv"

# Define the output directory
output_dir="/root/.meraki_port_mig/serial"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
  echo "File $input_file not found."
  exit 1
fi

# Check if the output directory exists, create if it doesn't
if [ ! -d "$output_dir" ]; then
  mkdir -p "$output_dir"
  echo "Created directory: $output_dir"
fi

# Read the input file line by line
while IFS= read -r line; do
  # Extract the content before the first comma
  filename="${line%%,*}"

  # Ensure the filename is valid and not empty
  if [ -n "$filename" ]; then
    # Define the full path for the output file
    filepath="$output_dir/$filename"

    # Create the file
    touch "$filepath"
    echo "Created file: $filepath"

    # Use grep to find all matches of the format QXXX-XXXX-XXXX in the line
    matches=$(echo "$line" | grep -oE 'Q[0-9A-Za-z]{3}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}')

    # Write all matches into the file
    if [ -n "$matches" ]; then
      echo "$matches" > "$filepath"
      echo "Written matches to file: $matches"
    else
      echo "No matches found for QXXX-XXXX-XXXX in line."
    fi
  else
    echo "Warning: Empty filename extracted, skipping line."
  fi
done < "$input_file"

rm -f /root/.meraki_port_mig/tmp/IP_ADDRESS

#update the ip_list with current ip addresses
ls /root/.meraki_port_mig/tmp/ > /root/.meraki_port_mig/ip_list
