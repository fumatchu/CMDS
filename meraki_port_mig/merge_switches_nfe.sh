#!/bin/bash

# Define the input file with entries
input_file="/root/port_migration/staging/port_merge.csv"  # Ensure this is the correct path

# Define the output directory for the new files
output_dir="/root/.meraki_port_mig/tmp"
mkdir -p "$output_dir"

# Define the directory for serial files
serial_dir="/root/.meraki_port_mig/serial"
mkdir -p "$serial_dir"

# Define the configuration file to be updated
config_file="/root/.meraki_port_mig/parse_switch.sh"

# Initialize variables
pair=()

# Read through the input file line by line
while IFS= read -r line; do
    # Add the current line to the pair array
    pair+=("$line")

    # If the pair array has two entries, process and write them to a new file
    if (( ${#pair[@]} == 2 )); then
        # Extract IP address and number from the first line of the pair
        if [[ ${pair[0]} =~ ^([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}),([0-9]+), ]]; then
            ip1="${BASH_REMATCH[1]}"
            useroption1="${BASH_REMATCH[2]}"
        fi

        # Extract IP address and number from the second line of the pair
        if [[ ${pair[1]} =~ ^([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}),([0-9]+), ]]; then
            ip2="${BASH_REMATCH[1]}"
            useroption2="${BASH_REMATCH[2]}"
        fi

        # Determine a unique file name by checking existing files
        file_index=1
        output_file="$output_dir/${ip1}_${file_index}.txt"
        while [[ -f "$output_file" ]]; do
            ((file_index++))
            output_file="$output_dir/${ip1}_${file_index}.txt"
        done

        # Write the pair to the determined output file
        echo -e "${pair[0]}\n${pair[1]}" > "$output_file"
        echo "Created file: $output_file"

        # Reset the pair array for the next set of two lines
        pair=()
    fi
done < "$input_file"

# If there's an odd entry left, write it to a new file using its IP
if (( ${#pair[@]} == 1 )); then
    if [[ ${pair[0]} =~ ^([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}),([0-9]+), ]]; then
        ip1="${BASH_REMATCH[1]}"
        useroption1="${BASH_REMATCH[2]}"
        file_index=1
        output_file="$output_dir/${ip1}_${file_index}.txt"
        while [[ -f "$output_file" ]]; do
            ((file_index++))
            output_file="$output_dir/${ip1}_${file_index}.txt"
        done
        echo -e "${pair[0]}" > "$output_file"
        echo "Created file: $output_file"
    fi
fi

echo "File creation complete. Proceeding with parsing..."

# Read each file in the output directory and update the config file
for file in "$output_dir"/*.txt; do
    if [[ -f "$file" ]]; then
        # Extract IP addresses and user options from the file
        {
            read -r line1
            read -r line2
        } < "$file"

        if [[ $line1 =~ ^([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}),([0-9]+), ]]; then
            ip1="${BASH_REMATCH[1]}"
            useroption1="${BASH_REMATCH[2]}"
            sed -i "s/^IP1=.*/IP1=${ip1}/" "$config_file"
            sed -i "s/^AIP=.*/AIP=${ip1}/" "$config_file"
            sed -i "s/^USEROPTION1=.*/USEROPTION1=${useroption1}/" "$config_file"
        fi

        if [[ $line2 =~ ^([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}),([0-9]+), ]]; then
            ip2="${BASH_REMATCH[1]}"
            useroption2="${BASH_REMATCH[2]}"
            sed -i "s/^IP2=.*/IP2=${ip2}/" "$config_file"
            sed -i "s/^USEROPTION2=.*/USEROPTION2=${useroption2}/" "$config_file"
        fi

        echo "Updated $config_file with IP1=${ip1}, IP2=${ip2}, USEROPTION1=${useroption1}, and USEROPTION2=${useroption2} from file $file"

        # Execute the script after updating the configuration
        /root/.meraki_port_mig/parse_switch.sh
        /root/.meraki_port_mig/merge_switches_nfe_end.sh

        # Use sed to clear the values for IP1, IP2, USEROPTION1, USEROPTION2, and AIP
        sed -i 's/^IP1=.*/IP1=/' "$config_file"
        sed -i 's/^IP2=.*/IP2=/' "$config_file"
        sed -i 's/^USEROPTION1=.*/USEROPTION1=/' "$config_file"
        sed -i 's/^USEROPTION2=.*/USEROPTION2=/' "$config_file"
        sed -i 's/^AIP=.*/AIP=/' "$config_file"

        # Extract the last entry's serial number from the file and create a new file
        last_entry=$(tail -n 1 "$file")
        if [[ $last_entry =~ (Q[A-Z0-9]{3}-[A-Z0-9]{4}-[A-Z0-9]{4})$ ]]; then
            serial="${BASH_REMATCH[1]}"
            ip_for_serial="${last_entry%%,*}"  # Get the IP part before the first comma
            serial_output_file="$serial_dir/${ip_for_serial}.txt"
           echo "$serial" > "$serial_output_file"
            echo "Created serial file: $serial_output_file"
        fi
    fi
done

#echo "Processing complete."


# Define the input file with entries
#input_file="/root/port_migration/staging/port_merge.csv"  # Ensure this is the correct path

# Define the directory for serial files
#serial_dir="/root/.meraki_port_mig/serial"
#mkdir -p "$serial_dir"

# Read through the input file line by line
#while IFS= read -r line; do
#    # Extract the IP address and serial number if present
#    if [[ $line =~ ^([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}),[0-9]+,(Q[A-Z0-9]{3}-[A-Z0-9]{4}-[A-Z0-9]{4}) ]]; then
#        ip="${BASH_REMATCH[1]}"
#        serial="${BASH_REMATCH[2]}"

        # Determine a unique file name by checking existing files
#        file_index=1
#        serial_output_file="$serial_dir/${ip}.txt"
#        while [[ -f "$serial_output_file" ]]; do
#            serial_output_file="$serial_dir/${ip}_${file_index}.txt"
#            ((file_index++))
#        done

#        # Write the serial number to the determined output file
#        echo "$serial" > "$serial_output_file"
#        echo "Created serial file: $serial_output_file"
#    fi
#done < "$input_file"
#echo "Processing complete."
