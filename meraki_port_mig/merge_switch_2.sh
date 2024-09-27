#!/bin/bash
#Batch Clean for Server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)


INPUT="/root/.meraki_port_mig/ip_list"

# Read file line-by-line to get an IP address
while read -r IP; do


sed -i -e 's/\bGigabitEthernet1\/0\/1\b/GigabitEthernet1\/0\/25/g' \
-e 's/\bGigabitEthernet0\/2\b/GigabitEthernet0\/26/g' \
-e 's/\bGigabitEthernet0\/3\b/GigabitEthernet0\/27/g' \
-e 's/\bGigabitEthernet0\/4\b/GigabitEthernet0\/28/g' \
-e 's/\bGigabitEthernet0\/5\b/GigabitEthernet0\/29/g' \
-e 's/\bGigabitEthernet0\/6\b/GigabitEthernet0\/30/g' \
-e 's/\bGigabitEthernet0\/7\b/GigabitEthernet0\/31/g' \
-e 's/\bGigabitEthernet0\/8\b/GigabitEthernet0\/32/g' \
-e 's/\bGigabitEthernet0\/9\b/GigabitEthernet0\/33/g' \
-e 's/\bGigabitEthernet0\/10\b/GigabitEthernet0\/34/g' \
-e 's/\bGigabitEthernet0\/11\b/GigabitEthernet0\/35/g' \
-e 's/\bGigabitEthernet0\/12\b/GigabitEthernet0\/36/g' \
-e 's/\bGigabitEthernet0\/13\b/GigabitEthernet0\/37/g' \
-e 's/\bGigabitEthernet0\/14\b/GigabitEthernet0\/38/g' \
-e 's/\bGigabitEthernet0\/15\b/GigabitEthernet0\/39/g' \
-e 's/\bGigabitEthernet0\/16\b/GigabitEthernet0\/40/g' \
-e 's/\bGigabitEthernet0\/17\b/GigabitEthernet0\/41/g' \
-e 's/\bGigabitEthernet0\/18\b/GigabitEthernet0\/42/g' \
-e 's/\bGigabitEthernet0\/19\b/GigabitEthernet0\/43/g' \
-e 's/\bGigabitEthernet0\/20\b/GigabitEthernet0\/44/g' \
-e 's/\bGigabitEthernet0\/21\b/GigabitEthernet0\/45/g' \
-e 's/\bGigabitEthernet0\/22\b/GigabitEthernet0\/46/g' \
-e 's/\bGigabitEthernet0\/23\b/GigabitEthernet0\/47/g' \
-e 's/\bGigabitEthernet0\/24\b/GigabitEthernet0\/48/g' /root/.meraki_port_mig/${IP}

done <"$INPUT"
