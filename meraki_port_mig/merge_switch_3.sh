#!/bin/bash
#Batch Clean for Server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)


INPUT="/root/ip_list"

# Read file line-by-line to get an IP address
while read -r IP; do


sed -i -e 's/\bGigabitEthernet1\/0\/1\b/GigabitEthernet1\/0\/25/g' \
-e 's/\bGigabitEthernet1\/0\/2\b/GigabitEthernet1\/0\/26/g' \
-e 's/\bGigabitEthernet1\/0\/3\b/GigabitEthernet1\/0\/27/g' \
-e 's/\bGigabitEthernet1\/0\/4\b/GigabitEthernet1\/0\/28/g' \
-e 's/\bGigabitEthernet1\/0\/5\b/GigabitEthernet1\/0\/29/g' \
-e 's/\bGigabitEthernet1\/0\/6\b/GigabitEthernet1\/0\/30/g' \
-e 's/\bGigabitEthernet1\/0\/7\b/GigabitEthernet1\/0\/31/g' \
-e 's/\bGigabitEthernet1\/0\/8\b/GigabitEthernet1\/0\/32/g' \
-e 's/\bGigabitEthernet1\/0\/9\b/GigabitEthernet1\/0\/33/g' \
-e 's/\bGigabitEthernet1\/0\/10\b/GigabitEthernet1\/0\/34/g' \
-e 's/\bGigabitEthernet1\/0\/11\b/GigabitEthernet1\/0\/35/g' \
-e 's/\bGigabitEthernet1\/0\/12\b/GigabitEthernet1\/0\/36/g' \
-e 's/\bGigabitEthernet1\/0\/13\b/GigabitEthernet1\/0\/37/g' \
-e 's/\bGigabitEthernet1\/0\/14\b/GigabitEthernet1\/0\/38/g' \
-e 's/\bGigabitEthernet1\/0\/15\b/GigabitEthernet1\/0\/39/g' \
-e 's/\bGigabitEthernet1\/0\/16\b/GigabitEthernet1\/0\/40/g' \
-e 's/\bGigabitEthernet1\/0\/17\b/GigabitEthernet1\/0\/41/g' \
-e 's/\bGigabitEthernet1\/0\/18\b/GigabitEthernet1\/0\/42/g' \
-e 's/\bGigabitEthernet1\/0\/19\b/GigabitEthernet1\/0\/43/g' \
-e 's/\bGigabitEthernet1\/0\/20\b/GigabitEthernet1\/0\/44/g' \
-e 's/\bGigabitEthernet1\/0\/21\b/GigabitEthernet1\/0\/45/g' \
-e 's/\bGigabitEthernet1\/0\/22\b/GigabitEthernet1\/0\/46/g' \
-e 's/\bGigabitEthernet1\/0\/23\b/GigabitEthernet1\/0\/47/g' \
-e 's/\bGigabitEthernet1\/0\/24\b/GigabitEthernet1\/0\/48/g' ./${IP}

done <"$INPUT"
