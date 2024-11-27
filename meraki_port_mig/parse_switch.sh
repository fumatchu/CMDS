#!/bin/bash
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

IP1=
IP2=
USEROPTION1=
USEROPTION2=
AIP=

sed -n '/interface GigabitEthernet/,$p' /var/lib/tftpboot/port_switch/${AIP} >/root/.meraki_port_mig/cisco_config.tmp

awk 'BEGIN {found=0} /interface GigabitEthernet1\/0\/1/ && !found {print "switch 1"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet2\/0\/1/ && !found {print "switch 2"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet3\/0\/1/ && !found {print "switch 3"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet4\/0\/1/ && !found {print "switch 4"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet5\/0\/1/ && !found {print "switch 5"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet6\/0\/1/ && !found {print "switch 6"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet7\/0\/1/ && !found {print "switch 7"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet8\/0\/1/ && !found {print "switch 8"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface GigabitEthernet9\/0\/1/ && !found {print "switch 9"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet1\/0\/1/ && !found {print "switch 1"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet2\/0\/1/ && !found {print "switch 2"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet3\/0\/1/ && !found {print "switch 3"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet4\/0\/1/ && !found {print "switch 4"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet5\/0\/1/ && !found {print "switch 5"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet6\/0\/1/ && !found {print "switch 6"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet7\/0\/1/ && !found {print "switch 7"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet8\/0\/1/ && !found {print "switch 8"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface TwoGigabitEthernet9\/0\/1/ && !found {print "switch 9"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet1\/0\/1/ && !found {print "switch 1"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet2\/0\/1/ && !found {print "switch 2"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet3\/0\/1/ && !found {print "switch 3"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet4\/0\/1/ && !found {print "switch 4"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet5\/0\/1/ && !found {print "switch 5"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet6\/0\/1/ && !found {print "switch 6"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet7\/0\/1/ && !found {print "switch 7"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet8\/0\/1/ && !found {print "switch 8"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
awk 'BEGIN {found=0} /interface FiveGigabitEthernet9\/0\/1/ && !found {print "switch 9"; found=1} {print}' /root/.meraki_port_mig/cisco_config.tmp >temp && mv -f temp /root/.meraki_port_mig/cisco_config.tmp
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
    output_dir="/root/.meraki_port_mig/staging"
    mkdir -p "$output_dir"

    # Parse the configuration file and create a new file for each switch
    parse_config() {
       local current_switch=""
       local output_file=""

        while IFS= read -r line; do
            if [[ "$line" =~ ^switch\ ([0-9]+)$ ]]; then
                # Extract the switch number
                switch_number="${BASH_REMATCH[1]}"
                current_switch="${AIP}switch$switch_number"
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





echo "${GREEN}Parsing complete${TEXTRESET}"
sleep 1