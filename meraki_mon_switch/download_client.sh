
#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
clear


cat <<EOF

${GREEN}Download Client for Meraki Onboarding ${TEXTRESET}

You can Download the Onboarding client for the Following Operating Systems:
${YELLOW}
Windows
https://mars-onboarding-app-production.s3.us-east-2.amazonaws.com/releases/catalyst-onboarder-latest.exe

MAC
https://mars-onboarding-app-production.s3.us-east-2.amazonaws.com/releases/catalyst-onboarder-latest.dmg

Linux
https://mars-onboarding-app-production.s3.us-east-2.amazonaws.com/releases/catalyst-onboarder-latest.AppImage
${TEXTRESET}
If this is your first time running the onboarding application, and you need assistance, refer to this link for documentation and details 
https://documentation.meraki.com/Cloud_Monitoring_for_Catalyst/Onboarding/Cloud_Monitoring_for_Catalyst_Onboarding_Guide

The Onboarding client is going to ask you to login with your Meraki API Key:

EOF


cat /root/.meraki_mon_switch/api_key.key


cat << EOF

The Onboarding application will also ask you for the list of IP addresses. 

EOF


cat /root/.meraki_mon_switch/ip_list


cat << EOF
${GREEN}
***********************************************************************************************
The Pre-Check is complete! Please use the Meraki Onboarding application to complete the process
***********************************************************************************************
${TEXTRESET}

EOF
read -p "Press Enter"
