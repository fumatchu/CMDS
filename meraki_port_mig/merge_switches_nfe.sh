#!/bin/bash

TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

# Define the input CSV file path
input_file="/root/port_migration/staging/port_merge.csv"  # Ensure this is the correct path

# Define the output directory for the new files
output_dir="/root/.meraki_port_mig/tmp"
mkdir -p "$output_dir"


# Define the directory to read files from
directory="/root/.meraki_port_mig/tmp"

# Check if the first line starts with "IP_ADDRESS"
if head -n 1 "$input_file" | grep -q "^IP_ADDRESS"; then
    # If it does, remove the first line
    sed -i '1d' "$input_file"
    sleep 1

else
    echo "Processing File"
fi

read -p "PAUSE"


# Initialize an array to store pairs of lines
pair=()
# Counter to increment file names
file_counter=1

# Read through the input file line by line
while IFS=, read -r ip useroption; do
    # Stop processing if the line contains "END"
    if [[ "$ip" == "END" ]]; then
        break
    fi

    # Add the current line to the pair array
    pair+=("$ip,$useroption")

    # If the pair array has two entries, process them
    if (( ${#pair[@]} == 2 )); then
        # Compare the two IP addresses in the pair
        if [[ "${pair[0]%%,*}" == "${pair[1]%%,*}" ]]; then
            # Extract the IP address for the file name
            ip="${pair[0]%%,*}"
            output_file="$output_dir/${ip}_stack_$file_counter.txt"
            echo -e "${pair[0]}\n${pair[1]}" > "$output_file"
        else
            # Extract the IP address for the first entry
            ip1="${pair[0]%%,*}"
            output_file="$output_dir/${ip1}_single_$file_counter.txt"
            echo -e "${pair[0]}\n${pair[1]}" > "$output_file"
        fi

        # Increment the file counter for the next file
        ((file_counter++))

        # Reset the pair array for the next set of two lines
        pair=()
    fi
done < "$input_file"

# Handle the case if there's an odd number of lines
if (( ${#pair[@]} == 1 )); then
    ip="${pair[0]%%,*}"
    output_file="$output_dir/${ip}_single_$file_counter.txt"
    echo "Running command single for IP: ${pair[0]}"
    echo "${pair[0]}" > "$output_file"
fi




# Define the path to the parse_switch.sh file
parse_switch_file="/root/.meraki_port_mig/parse_switch.sh"

# Process each file in the directory (For STACKED Switches)
for file in "$directory"/*stack*.txt; do
#for file in "$directory"/*single*.txt; do
    # Check if the file exists and is readable
    if [[ -f "$file" && -r "$file" ]]; then
        echo "Processing file: $file"

        # Initialize a counter to track line number
        line_number=0

        # Read each line in the file
        while IFS=, read -r ip number serial; do
            ((line_number++))
            if [[ $line_number -eq 1 ]]; then
                # Set the variables from the first line
                IP1="$ip"
                USEROPTION1="$number"
                AIP="$IP1"

                # Output the variables for the first line
                echo "IP1=$IP1"
                echo "USEROPTION1=$USEROPTION1"
                echo "AIP (first line)=$AIP"
                echo "Serial number removed: $serial"

                # Use sed to update the parse_switch.sh file with the variables
                sed -i "s/^IP1=.*/IP1=${IP1}/" "$parse_switch_file"
                sed -i "s/^USEROPTION1=.*/USEROPTION1=${USEROPTION1}/" "$parse_switch_file"
                sed -i "s/^AIP=.*/AIP=${AIP}/" "$parse_switch_file"
                $parse_switch_file

            elif [[ $line_number -eq 2 ]]; then
                # Set the variables from the second line
                IP2="$ip"
                USEROPTION2="$number"
                AIP="$IP2"

                # Output the variables for the second line
                echo "IP2=$IP2"
                echo "USEROPTION2=$USEROPTION2"
                echo "AIP (second line)=$AIP"

                # Use sed to update the parse_switch.sh file with the variables
                sed -i "s/^IP2=.*/IP2=${IP2}/" "$parse_switch_file"
                sed -i "s/^USEROPTION2=.*/USEROPTION2=${USEROPTION2}/" "$parse_switch_file"
                sed -i "s/^AIP=.*/AIP=${AIP}/" "$parse_switch_file"
                $parse_switch_file
                #Execute the Merge
                /root/.meraki_port_mig/merge_switches_nfe_end.sh
                # Break after processing the second line
                break
            fi
        done < "$file"
    fi
done

read -p "PAUSE Now going to process files"

# Process each file in the directory (For SINGLE Switches)
#for file in "$directory"/*stack*.txt; do
for file in "$directory"/*single*.txt; do
    # Check if the file exists and is readable
    if [[ -f "$file" && -r "$file" ]]; then
        echo "Processing file: $file"

        # Initialize a counter to track line number
        line_number=0

        # Read each line in the file
        while IFS=, read -r ip number serial; do
            ((line_number++))
            if [[ $line_number -eq 1 ]]; then
                # Set the variables from the first line
                IP1="$ip"
                USEROPTION1="$number"
                AIP="$IP1"

                # Output the variables for the first line
                echo "IP1=$IP1"
                echo "USEROPTION1=$USEROPTION1"
                echo "AIP (first line)=$AIP"
                echo "Serial number removed: $serial"

                # Use sed to update the parse_switch.sh file with the variables
                sed -i "s/^IP1=.*/IP1=${IP1}/" "$parse_switch_file"
                sed -i "s/^USEROPTION1=.*/USEROPTION1=${USEROPTION1}/" "$parse_switch_file"
                sed -i "s/^AIP=.*/AIP=${AIP}/" "$parse_switch_file"
                $parse_switch_file

            elif [[ $line_number -eq 2 ]]; then
                # Set the variables from the second line
                IP2="$ip"
                USEROPTION2="$number"
                AIP="$IP2"

                # Output the variables for the second line
                echo "IP2=$IP2"
                echo "USEROPTION2=$USEROPTION2"
                echo "AIP (second line)=$AIP"

                # Use sed to update the parse_switch.sh file with the variables
                sed -i "s/^IP2=.*/IP2=${IP2}/" "$parse_switch_file"
                sed -i "s/^USEROPTION2=.*/USEROPTION2=${USEROPTION2}/" "$parse_switch_file"
                sed -i "s/^AIP=.*/AIP=${AIP}/" "$parse_switch_file"
                $parse_switch_file
                #Execute the Merge
                /root/.meraki_port_mig/merge_switches_nfe_end.sh
                # Break after processing the second line
                break
            fi
        done < "$file"
    fi
done
read -p "Press Enter"
