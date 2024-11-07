#!/bin/bash
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
INPUT="/root/.meraki_mig/ip_list"

while read -r IP; do
    # Print the IP address to the console
    echo "Migrating ports for $IP"
    sleep 2
    CONFIGSTACK=$(cat /var/lib/tftpboot/mig_switch/$IP | grep -m 1 -o '2/0/1')
    INTGI=$(cat /var/lib/tftpboot/mig_switch/$IP | grep -m 1 -o 'interface GigabitEthernet1/0/1')
    INTTWO=$(cat /var/lib/tftpboot/mig_switch/$IP | grep -m 1 -o 'interface TwoGigabitEthernet1/0/1')
    INTTEN=$(cat /var/lib/tftpboot/mig_switch/$IP | grep -m 1 -o 'interface TenGigabitEthernet1/0/1')
    #Determine if this switch is a stack or a single switch
    #Stacked Switch
    if [[ "$CONFIGSTACK" == "2/0/1" && "$INTGI" == "interface GigabitEthernet1/0/1" ]]; then
        echo "${GREEN}This looks to be a stack of switches with Gigabit Interfaces${TEXTRESET}"
        sleep 2
        sed -i '/^IP=/c\IP=' /root/.meraki_mig/convert_stack_single.sh
        sed -i "s/IP=/IP=${IP}/g" /root/.meraki_mig/convert_stack_single.sh
        /root/.meraki_mig/convert_stack_single.sh
        rm -r -f /root/.meraki_mig/serial.txt
        rm -r -f /root/.meraki_mig/cisco_config.tmp
        rm -r -f /root/.meraki_mig/cisco_config_up.tmp
    else
        echo " "
    fi

    if [[ "$CONFIGSTACK" == "2/0/1" && "$INTTWO" == "interface TwoGigabitEthernet1/0/1" ]]; then
        echo "${GREEN}This looks to be a stack of switches with MultiGigabit Interfaces${TEXTRESET}"
        sleep 2
        sed -i '/^IP=/c\IP=' /root/.meraki_mig/convert_stack_single.sh
        sed -i "s/IP=/IP=${IP}/g" /root/.meraki_mig/convert_stack_single.sh
        /root/.meraki_mig/convert_stack_single.sh
        rm -r -f /root/.meraki_mig/serial.txt
        rm -r -f /root/.meraki_mig/cisco_config.tmp
        rm -r -f /root/.meraki_mig/cisco_config_up.tmp
    else
        echo " "
    fi

    if [[ "$CONFIGSTACK" == "2/0/1" && "$INTTEN" == "interface TenGigabitEthernet1/0/1" ]]; then
        echo "${GREEN}This looks to be a stack of switches with MultiGigabit Interfaces${TEXTRESET}"
        sleep 2
        sed -i '/^IP=/c\IP=' /root/.meraki_mig/convert_stack_single.sh
        sed -i "s/IP=/IP=${IP}/g" /root/.meraki_mig/convert_stack_single.sh
        /root/.meraki_mig/convert_stack_single.sh
        rm -r -f /root/.meraki_mig/serial.txt
        rm -r -f /root/.meraki_mig/cisco_config.tmp
        rm -r -f /root/.meraki_mig/cisco_config_up.tmp
    else
        echo " "
    fi

    ##Single Switch
    if [[ "$CONFIGSTACK" == "" && "$INTGI" == "interface GigabitEthernet1/0/1" ]]; then
        echo "${GREEN}${IP} looks to be a single switch with Gigabit Interfaces${TEXTRESET}"
        sleep 2
        sed -i '/^IP=/c\IP=' /root/.meraki_mig/convert_stack_single.sh
        sed -i "s/IP=/IP=${IP}/g" /root/.meraki_mig/convert_stack_single.sh
        /root/.meraki_mig/convert_stack_single.sh
        rm -r -f /root/.meraki_mig/serial.txt
        rm -r -f /root/.meraki_mig/cisco_config.tmp
        rm -r -f /root/.meraki_mig/cisco_config_up.tmp
    else
        echo " "
    fi

    if [[ "$CONFIGSTACK" == "" && "$INTTWO" == "interface TwoGigabitEthernet1/0/1" ]]; then
        echo "${GREEN}${IP} looks to be a single switch with MultiGigabit Interfaces${TEXTRESET}"
        sleep 2
        sed -i '/^IP=/c\IP=' /root/.meraki_mig/convert_stack_single.sh
        sed -i "s/IP=/IP=${IP}/g" /root/.meraki_mig/convert_stack_single.sh
        /root/.meraki_mig/convert_stack_single.sh
        rm -r -f /root/.meraki_mig/serial.txt
        rm -r -f /root/.meraki_mig/cisco_config.tmp
        rm -r -f /root/.meraki_mig/cisco_config_up.tmp
    else
        echo " "
    fi

    if [[ "$CONFIGSTACK" == "" && "$INTTEN" == "interface TenGigabitEthernet1/0/1" ]]; then
        echo "${GREEN}${IP} looks to be a single switch with MultiGigabit Interfaces${TEXTRESET}"
        sleep 2
        sleep 2
        sed -i '/^IP=/c\IP=' /root/.meraki_mig/convert_stack_single.sh
        sed -i "s/IP=/IP=${IP}/g" /root/.meraki_mig/convert_stack_single.sh
        /root/.meraki_mig/convert_stack_single.sh
        rm -r -f /root/.meraki_mig/serial.txt
        rm -r -f /root/.meraki_mig/cisco_config.tmp
        rm -r -f /root/.meraki_mig/cisco_config_up.tmp
    else
        echo " "
    fi

done <"$INPUT"
echo "Migration Script Complete"
sleep 2
