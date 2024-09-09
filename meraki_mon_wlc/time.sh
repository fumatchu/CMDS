#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

num_switches=$(< /root/.meraki_mon_wlc/ip_list wc -l)
upgrade_time=600
reboot_time=180

#a=$(( 1+2*k ))

upg_seconds=$(( upgrade_time*num_switches ))

reboot_seconds=$(( reboot_time*num_switches ))

total_seconds=$(( reboot_seconds+upg_seconds ))

date -ud "@$total_seconds" +"${YELLOW}$(( $total_seconds/3600/24 )) days %H hours %M minutes %S seconds"${TEXTRESET}
