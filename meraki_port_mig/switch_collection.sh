#!/bin/bash
#Create csv of collected switches
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
SERVER_IP=$(hostname -I)

mkdir -p /root/.meraki_port_mig/tmp
rm -f -r /root/port_migration/*
rm -r -f /root/.meraki_port_mig/tmp/*
mkdir -p /root/port_migration/staging

#Check if the file exists
# Define the file path
file_path="/root/port_migration/switch_collection.csv"

# Check if the file exists
if [[ -f "$file_path" ]]; then
    # Prompt the user for confirmation
    read -p "The file $file_path exists. Do you want to overwrite it? (Y/N): " response

    # Check user response
    if [[ "$response" == "Y" || "$response" == "y" ]]; then
        # Delete the file
        rm "$file_path"
        echo "File $file_path has been deleted."
    else
        echo "File $file_path will not be overwritten."
    fi
else
    echo "File $file_path does not exist."
fi

INPUT="/root/.meraki_port_mig/ip_list"

# Read file line-by-line to get an IP address
while read -r IP; do
#Get IP Address
echo ${IP} >> /root/.meraki_port_mig/tmp/IP-${IP}
#Get hostname
    HOSTNAME=$(cat /var/lib/tftpboot/port_switch/${IP} | grep hostname | cut -c10-)
    echo "$HOSTNAME" >> /root/.meraki_port_mig/tmp/hostname${IP}
#Get Switch Model
    SWITCHMODEL=$(cat /var/lib/tftpboot/port_switch/${IP}-shver | grep "Model Number" | tr -d "[:blank:]" | cut -c13-)
    echo "$SWITCHMODEL" >>/root/.meraki_port_mig/tmp/model${IP}
#If stack concatenate
# Input file
input_file="/root/.meraki_port_mig/tmp/model${IP}"  # Replace with your actual input file path
# Check if the input file exists
if [[ ! -f "$input_file" ]]; then
    echo "Error: Input file $input_file does not exist."
    exit 1
fi

# Count the number of lines in the input file
line_count=$(wc -l < "$input_file")
# Check if the line count is more than one
if [[ "$line_count" -gt 1 ]]; then
    # Create a temporary file
    touch /root/.meraki_port_mig/tmp/tmp.file
    paste -sd ' ' /root/.meraki_port_mig/tmp/model${IP} > /root/.meraki_port_mig/tmp/tmp.file

    mv /root/.meraki_port_mig/tmp/tmp.file /root/.meraki_port_mig/tmp/model${IP}
    rm -f /root/.meraki_port_mig/tmp/tmp.file

    echo "Concatenated all lines after the first line into the first line in $input_file."
else
    echo "The input file $input_file has one line or fewer. No changes made."
fi
#Get Serial Number
    SWITCHSERIAL=$(cat /var/lib/tftpboot/port_switch/${IP}-shver | grep "Motherboard Serial Number" | tr -d "[:blank:]" | cut -c25-)
    echo "$SWITCHSERIAL" >>/root/.meraki_port_mig/tmp/serial${IP}

#If stack concatenate
#If there is more than one switch (stack) concatenate the file
# Input file
input_file="/root/.meraki_port_mig/tmp/serial${IP}"  # Replace with your actual input file path
# Check if the input file exists
if [[ ! -f "$input_file" ]]; then
    echo "Error: Input file $input_file does not exist."
    exit 1
fi
# Count the number of lines in the input file
line_count=$(wc -l < "$input_file")
# Check if the line count is more than one
if [[ "$line_count" -gt 1 ]]; then
    # Create a temporary file
    touch /root/.meraki_port_mig/tmp/tmp.file
    paste -sd ' ' /root/.meraki_port_mig/tmp/serial${IP} > /root/.meraki_port_mig/tmp/tmp.file

    mv /root/.meraki_port_mig/tmp/tmp.file /root/.meraki_port_mig/tmp/serial${IP}
    rm -f /root/.meraki_port_mig/tmp/tmp.file

    echo "Concatenated all lines after the first line into the first line in $input_file."
else
    echo "The input file $input_file has one line or fewer. No changes made."
fi

done <"$INPUT"

#Merge Files together
# Read file line-by-line to get an IP address
while read -r IP; do

# Input files
file1="/root/.meraki_port_mig/tmp/IP-${IP}"  # Replace with your actual input file path for the first file
file2="/root/.meraki_port_mig/tmp/hostname${IP}"  # Replace with your actual input file path for the second file
file3="/root/.meraki_port_mig/tmp/serial${IP}"  # Replace with your actual input file path for the third file
file4="/root/.meraki_port_mig/tmp/model${IP}"
# Output file
output_file="/root/.meraki_port_mig/tmp/switch_collection.${IP}"  # Replace with your desired output file path
# Check if input files exist
if [[ ! -f "$file1" || ! -f "$file2" || ! -f "$file3" || ! -f "$file4" ]]; then
    echo "Error: One or more input files do not exist."
    exit 1
fi
# Ensure the output file is empty
> "$output_file"
# Read all three files line by line and merge them
paste -d ' ' "$file1" "$file2" "$file3" "$file4">> "$output_file"
echo "Files have been merged into $output_file."
done <"$INPUT"
# Merge All the separate collected files together into one file
# Directory containing the files to be merged
directory="/root/.meraki_port_mig/tmp/"  # Replace with your actual directory path

# Wildcard pattern to match files
pattern="switch_collection*"  # Replace with your actual wildcard pattern

# Output file
output_file="/root/.meraki_port_mig/switch_collection.final"  # Replace with your desired output file path

# Ensure the output file is empty
> "$output_file"

# Loop through each file matching the pattern in the directory
for file in "$directory"/$pattern; do
    # Check if the file exists and is not the output file itself
    if [[ -f "$file" && "$file" != "$output_file" ]]; then
        echo "Merging $file"
        # Append the content of the file to the output file
        cat "$file" >> "$output_file"
        # Optionally, add a newline between files to separate them
        echo "" >> "$output_file"
    fi
done

echo "Files have been merged into $output_file."




mkdir -p /root/port_migration/
#Remove Carriage returns
grep -v '^[[:space:]]*$' "/root/.meraki_port_mig/switch_collection.final" > "/root/.meraki_port_mig/switch_collection.final.tmp"
sed -e "s/ /,/g" </root/.meraki_port_mig/switch_collection.final.tmp >>/root/.meraki_port_mig/switch_collection.csv
sed -i '1i IP_ADDRESS,HOSTNAME,CAT_SERIAL,CAT_MODEL,MERAKI_SERIAL_NUMBER,' /root/.meraki_port_mig/switch_collection.csv
echo "If you are merging 24 port switches you sepcify the qty 1 Meraki Serial," >> /root/.meraki_port_mig/switch_collection.csv
echo "The first switch in becomes primary and the second switch does not need to be known," >> /root/.meraki_port_mig/switch_collection.csv
echo "EXAMPLE,,C9300-24,C9300-24,QXXX-1111-1111,QXXX-1111-1111," >> /root/.meraki_port_mig/switch_collection.csv
echo "EXAMPLE of a MERGED SWITCH, ,C9300-24,C9300-24,QXXX-1111-1111," >> /root/.meraki_port_mig/switch_collection.csv
echo "ANOTHER EXAMPLE-SINGLE SWITCHES,,C9300-24,C9300-24,C9300-24,C9300-24,QXXX-1111-1111,QXXX-1111-1111,QXXX-1111-1111,QXXX-1111-1111," >> /root/.meraki_port_mig/switch_collection.csv
echo "ANOTHER EXAMPLE-STACK SWITCHES,,C9300-24,C9300-24,C9300-24,C9300-24,QXXX-1111-1111,QXXX-1111-1111,QXXX-1111-1111,QXXX-1111-1111," >> /root/.meraki_port_mig/switch_collection.csv
echo "Please remove everything from this file except the header the END entry and your new information" >> /root/.meraki_port_mig/switch_collection.csv
echo "The final format of the file should look like this:" >> /root/.meraki_port_mig/switch_collection.csv
echo "IP_ADDRESS,HOSTNAME,CAT_SERIAL,CAT_MODEL,MERAKI_SERIAL_NUMBER," >> /root/.meraki_port_mig/switch_collection.csv
echo "DATA,DATA,DATA,DATA,DATA,DATA"  >> /root/.meraki_port_mig/switch_collection.csv
echo "Then the END statment"  >> /root/.meraki_port_mig/switch_collection.csv
echo "MAKE SURE THIS IS SAVED IN THE /root/port_migration/STAGING directory with the same name- switch_collection.csv" >> /root/.meraki_port_mig/switch_collection.csv
echo "https://$SERVER_IP:9090/=$SERVER_IP/navigator" | tr -d '[:blank:]' >> /root/.meraki_port_mig/switch_collection.csv
echo "END," >> /root/.meraki_port_mig/switch_collection.csv
mv /root/.meraki_port_mig/switch_collection.csv /root/port_migration

cat <<EOF

The Inventory csv file has been produced and is in the directory:

/root/port_migration

Which can be downloaded from this link:

EOF

echo "https://$SERVER_IP:9090/=$SERVER_IP/navigator" | tr -d '[:blank:]'




rm -f /root/.meraki_port_mig/switch_collection.csv
rm -f /root/.meraki_port_mig/switch_collection.final
rm -f /root/.meraki_port_mig/switch_collection.final.tmp
rm -r -f /root/.meraki_port_mig/tmp/*

read -p "Press Enter to Continue"
