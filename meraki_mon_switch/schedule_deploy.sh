#!/bin/bash
#Schedule Switch Upgrade with at
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Schedule IOS-XE Switch Upgrades${TEXTRESET}

You can schedule a time to run this command. Common format is HH:MM AM/PM
For example: 
To Run a job at 11:59 at night  --> 11:59 PM
To run a Job at 8:30 in the morning --> 8:30 AM
To run a job tomorrow at 1:00 AM (after this current day, past 12:00 AM) --> 1:00 AM tomorrow

The current time/date is:
EOF
date
echo " "

read -p "Please specify the time you would like to schedule: " TIME

cat <<EOF
${GREEN}Updating the Schedule${TEXTRESET}
EOF
sleep 1

echo /root/.meraki_mon_switch/deploy.sh | at ${TIME}

echo "These are the current jobs scehduled:"

atq

sleep 4
