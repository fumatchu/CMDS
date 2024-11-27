#!/bin/bash
#This will process the csv file and look for switches that need to be merged
# Define the input CSV file
input_file="/root/port_migration/staging/switch_collection.csv"  # Replace with your actual CSV file path

# Regular expression for matching an IP address
ip_regex='([0-9]{1,3}\.){3}[0-9]{1,3}'

# Read the CSV file line by line
while IFS= read -r line; do
  # Check if the line contains "MERGE-" followed by an IP address
  if [[ "$line" =~ MERGE- ]]; then
    # Use awk to process each entry in the line
    echo "$line" | awk -F',' -v ipregex="$ip_regex" '
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
            num1 = last_number
          } else if (entry_count == 2) {
            ip2 = ip_address
            num2 = last_number
          }
        }
      }
      # Display the extracted values
      if (entry_count == 2) {
        print "IP1=" ip1 ", Number1=" num1 ", IP2=" ip2 ", Number2=" num2
      }
    }'
  fi
done < "$input_file"