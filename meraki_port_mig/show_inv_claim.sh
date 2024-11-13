#!/bin/bash
#Query show meraki output to serials
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)


cat /var/lib/tftpboot/mig_switch/*-shmr | grep -E -o "Q.{0,13}"
cat /var/lib/tftpboot/mig_switch/*-shmr | grep -E -o "Q.{0,13}" >/root/.meraki_mig/switch_serials.txt


clear
python3.10 /root/.meraki_mig/claim_devices.py

sleep 4
