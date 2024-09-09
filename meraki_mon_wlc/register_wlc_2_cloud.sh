#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
INPUT="/root/.meraki_mon_wlc/ip_list"
clear
rm -r -f /root/.meraki_mon_wlc/logs/registration.log
touch /root/.meraki_mon_wlc/check.tmp
cat <<EOF
${GREEN}Register WLC to Cloud${TEXTRESET}
Registering the WLC to the Cloud

EOF

sleep 2

/root/.meraki_mon_wlc/register_wlc_2_cloud.exp

clear

cat <<EOF
${YELLOW}Waiting for WLC Registration${TEXTRESET}
EOF

echo "Please Wait..."
i=45;while [ $i -gt 0 ];do if [ $i -gt 9 ];then printf "\b\b$i";else  printf "\b\b $i";fi;sleep 1;i=`expr $i - 1`;done
clear
/root/.meraki_mon_wlc/register_wlc_2_cloud_check.exp

clear

cat <<EOF
${GREEN}Current status of WLC Registration${TEXTRESET}
EOF
# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo ${GREEN}"$IP"${TEXTRESET} | tee -a /root/.meraki_mon_wlc/logs/registration.log
  echo " "
cat /var/lib/tftpboot/wlc/${IP}-sh-meraki-connect | grep "Fetch State" | tee -a /root/.meraki_mon_wlc/logs/registration.log
echo " "
cat /var/lib/tftpboot/wlc/${IP}-sh-meraki-connect | grep "Meraki Tunnel State" -A 3 | tee -a /root/.meraki_mon_wlc/logs/registration.log
echo " "
cat /var/lib/tftpboot/wlc/${IP}-sh-meraki-connect | grep "Meraki Tunnel Config" -A 8 | tee -a /root/.meraki_mon_wlc/logs/registration.log
echo " "
cat /var/lib/tftpboot/wlc/${IP}-sh-meraki-connect | grep "Meraki Device Registration" -A 9 | tee -a /root/.meraki_mon_wlc/logs/registration.log
echo " "
clear
done <"$INPUT"

#Are the Tunnels UP?
  TUNNELDOWN1=$(cat /root/.meraki_mon_wlc/logs/registration.log | tr -d "[:blank:]" | grep Primary:Down)
  TUNNELDOWN2=$(cat /root/.meraki_mon_wlc/logs/registration.log | tr -d "[:blank:]" | grep Secondary:Down)

  if [ "$TUNNELDOWN1" = "Primary:Down" ] || [ "$TUNNELDOWN2" = "Secondary:Down" ] ; then
    echo "1" >> /root/.meraki_mon_wlc/check.tmp
    echo "${RED}At least one WLC could not bring up it's tunnel${TEXTRESET}"
    echo "Please review the Registration log ${YELLOW}(Main Menu --> Logs --> Registration Log)${TEXTRESET}"
    echo " "
  else
  echo " "
  fi

#What's the fetch Status?
  FETCH=$(cat /root/.meraki_mon_wlc/logs/registration.log | tr -d "[:blank:]" | grep FetchState:Configfetchfailed | sed -n '/^FetchState/ {p;q}')
  if [ "$FETCH" = "FetchState:Configfetchfailed" ] ; then
    echo "1" >> /root/.meraki_mon_wlc/check.tmp
    echo "${RED}At least one WLC could not Fetch it's configuration from the cloud${TEXTRESET}"
    echo "The Error was:"
    cat /root/.meraki_mon_wlc/logs/registration.log | grep "Fetch Fail" | grep "Could not"
    echo " "
    echo "Please review the Registration log ${YELLOW}(Main Menu --> Logs --> Registration Log)${TEXTRESET}"
  else
  echo " "
  fi


CHECK=$(cat /root/.meraki_mon_wlc/check.tmp | grep 1)
if grep -q '[^[:space:]]' "/root/.meraki_mon_wlc/check.tmp"; then
    echo " "
    echo "${RED}One or more WLC's had a registration a issue. ${TEXTRESET}"
    rm -r -f /root/.meraki_mon_wlc/check.tmp
    echo " "
    echo "Please correct the Issues before continuing."
    echo "Exiting Script in a Moment"
    sleep 20
    exit
  else
    echo " "
    echo ${GREEN}"All Registrations Successful ${TEXTRESET}"
    echo " "
    rm -r -f /root/.meraki_mon_wlc/check.tmp > /dev/null 2>&1
    sleep 5
  fi

/root/.meraki_mon_wlc/enable_avc.sh |  | tee -a /root/.meraki_mon_wlc/logs/avc_enable.log ;;
/root/.meraki_mon_wlc/claim_devices.sh
