#!/bin/bash


INPUT="/root/.meraki_mig/ip_list"

while read -r IP; do
  # Print the IP address to the console
  echo "Migrating ports for $IP"
  sleep 2
SERIAL=$(cat /var/lib/tftpboot/mig_switch/$IP-shmr | grep '1 \ C9300' | grep -E -o "Q.{0,13}")





#sed -i '0,/meraki_serial/{/meraki_serial/d;}' /root/.meraki_mig/port_migration.py

#echo meraki_serial = "'${SERIAL}'" >/root/.meraki_mig/serial.tmp
#sed -i '1s/^/    /' /root/.meraki_mig/serial.tmp
#sed -i '74 r /root/.meraki_mig/serial.tmp' /root/.meraki_mig/port_migration.py

#sed -n '/interface GigabitEthernet/,$p' /var/lib/tftpboot/mig_switch/${IP} > /root/.meraki_mig/cisco_config.tmp
#sleep 2

#autopep8 --in-place --aggressive --aggressive /root/.meraki_mig/port_migration.py
unbuffer python3.10 /root/.meraki_mig/port_migration.py



echo "complete"
sleep 1
rm -r -f /root/.meraki_mig/serial.tmp
done <"$INPUT"
