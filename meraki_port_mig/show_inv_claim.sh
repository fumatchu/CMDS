#!/bin/bash
#Query show meraki output to serials
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)


cat /root/.meraki_port_mig/serial/* | grep -E -o "Q.{0,13}"
cat /root/.meraki_port_mig/serial/* | grep -E -o "Q.{0,13}" >/root/.meraki_port_mig/switch_serials.txt


clear
python3.10 /root/.meraki_port_mig/claim_devices.py

sleep 4
