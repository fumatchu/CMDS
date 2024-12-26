#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
clear
sed -i '/^/d' /root/.meraki_mig/ip_list

touch /root/.meraki_mig/network_collection.tmp

cat << EOF
${GREEN}Network Discovery${TEXTRESET}

EOF
# Function to validate CIDR notation
is_valid_cidr() {
    local cidr="$1"
    # This regex checks for valid IPv4 addresses with a subnet mask between /0 and /32
    if [[ $cidr =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}/([0-9]|[1-2][0-9]|3[0-2])$ ]]; then
        # Split the IP and prefix
        IFS='/' read -r ip prefix <<< "$cidr"
        # Split the IP into its components
        IFS='.' read -r o1 o2 o3 o4 <<< "$ip"
        # Validate each octet is between 0 and 255
        if (( o1 <= 255 && o2 <= 255 && o3 <= 255 && o4 <= 255 )); then
            return 0
        fi
    fi
    return 1
}

# Prompt for subnet input
while true; do
    read -p "Please provide the subnet to scan in CIDR notation (i.e. 192.168.240.0/24): " SUBNET
    if [ -z "$SUBNET" ]; then
        echo "${RED}The response cannot be blank. Please try again."${TEXTRESET}
    elif is_valid_cidr "$SUBNET"; then
        echo "Valid CIDR notation: $SUBNET"
        break
    else
        echo "${RED}Invalid CIDR notation. Please try again."${TEXTRESET}
    fi
done

echo -e "Running Scan\nThis may take several minutes depending on the subnet size\nPlease Wait...\n"


# Start the spinner in the background
spin() {
  local pid=$1
  local delay=0.1
  local spinstr='|/-\'
  while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
    local temp=${spinstr#?}
    printf " [%c]  " "$spinstr"
    local spinstr=$temp${spinstr%"$temp"}
    sleep $delay
    printf "\b\b\b\b\b\b"
  done
  printf "    \b\b\b\b"
}

# Run the nmap command in the background
nmap -p 22 ${SUBNET} -oG /root/.meraki_mig/nmap_output > /dev/null 2>&1 &

# Get the process ID of the background job
nmap_pid=$!

# Run the spinner function with the nmap process ID
spin $nmap_pid

# Wait for the nmap command to complete
wait $nmap_pid

# Process the nmap output
cat /root/.meraki_mig/nmap_output | grep "22/open" | cut -c7- | cut -d "(" -f1 | sed -e 's/[\t ]//g;/^$/d'  > /root/.meraki_mig/discovered_ip

# Count the number of discovered IPs
num_devices=$(< /root/.meraki_mig/discovered_ip wc -l)

echo "${GREEN}Scan complete${TEXTRESET} Total IP Based Devices with SSH enabled: $num_devices"


cat << EOF

Logging into Switches and Collecting Eligibility
This may take several minutes based on the subnet size
Please Wait...
EOF


# Start the discovery.exp script in the background
/root/.meraki_mig/discovery.exp > /dev/null 2>&1 &

# Get the process ID of the background job
process_pid=$!

# Function to display a spinner
spin() {
  local delay=0.1
  local spinstr='|/-\'
  while [ "$(ps a | awk '{print $1}' | grep $1)" ]; do
    local temp=${spinstr#?}
    printf " [%c]  " "$spinstr"
    local spinstr=$temp${spinstr%"$temp"}
    sleep $delay
    printf "\b\b\b\b\b\b"
  done
  printf "    \b\b\b\b"
}

# Run the spinner function with the process ID
echo "Switch Collection is running, please wait..."
spin $process_pid

# Wait for the process to complete
wait $process_pid

echo "Process completed."


# Paths to the files and directories
ip_list_file="/root/.meraki_mig/discovered_ip"
tftpboot_dir="/var/lib/tftpboot/mig_switch"

# Temporary file to hold IPs that have corresponding files
temp_file=$(mktemp)

# Read each IP from the ip_list_file
while IFS= read -r ip; do
    # Construct the expected filename based on IP
    filename_prefix="nwd-$ip"

    # Check if any file in the directory starts with the expected filename
    if ls "$tftpboot_dir/$filename_prefix"* 1> /dev/null 2>&1; then
        # If the file exists, keep the IP in the list
        echo "$ip" >> "$temp_file"
    else
        echo " "
        echo "${YELLOW}The device with IP $ip was either unreachable or the credentials were incorrect."${TEXTRESET}
        echo "If you believe this to be an error, please review the credentials or status of the device."
        echo "${RED}Removing $ip from the Data collection list."${TEXTRESET}
        echo " "
    fi
done < "$ip_list_file"

# Replace the original ip_list_file with the updated list
mv "$temp_file" "$ip_list_file"

# Clean up the temporary file
rm -f "$temp_file"

cat << EOF
${GREEN}Checking eligibility${TEXTRESET}

EOF
/root/.meraki_mig/network_discovery_collection.sh > /dev/null 2>&1


more /root/.meraki_mig/network_collection.tmp | tee -a /root/.meraki_mig/logs/network_discovery
echo "Actual Provisioned Switches" | tee -a /root/.meraki_mig/logs/network_discovery > /dev/null 2>&1


INPUT="/root/.meraki_mig/ip_list"

# Read file line-by-line to get an IP address
while read -r IP; do

#Is the Switch already provisioned?
    MUSER=$(cat /var/lib/tftpboot/mig_switch/nwd-${IP}-shrunn | grep -Eo -m 1 "username meraki-user" | cut -c10-)
if [ "$MUSER" = "meraki-user" ]; then
    echo "${YELLOW}It looks like ${IP} is already provisioned for Catalyst Monitoring"${TEXTRESET}
    echo "${RED}Skipping..."${TEXTRESET}
    sed -i "0,/${IP}/d" /root/.meraki_mig/ip_list
    else
    echo " "

fi

done <"$INPUT"

cat /root/.meraki_mig/ip_list >> /root/.meraki_mig/logs/network_discovery
cat_num_devices=$(< /root/.meraki_mig/ip_list wc -l)
echo " "
echo "Total Eligible Catalyst Devices (9K): ${cat_num_devices}"
echo "Adding Eligible Switches to IP Batch List"
echo "The total estimated time to upgrade and install/reboot IOS-XE is:"
/root/.meraki_mig/time.sh

rm -r -f /root/.meraki_mig/network_collection.tmp
rm -r -f /var/lib/tftpboot/mig_switch/nwd*
rm -r -f /root/.meraki_mig/discovered_ip
rm -r -f /root/.meraki_mig/nmap_output
read -p "Press Enter"
