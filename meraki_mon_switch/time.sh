#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

num_switches=$(< /root/.meraki_mon_switch/ip_list wc -l)
upgrade_time=632
reboot_time=300



#a=$(( 1+2*k ))
seconds=$(( upgrade_time+reboot_time*num_switches ))

date -ud "@$seconds" +"${YELLOW}$(( $seconds/3600/24 )) days %H hours %M minutes %S seconds"${TEXTRESET}
