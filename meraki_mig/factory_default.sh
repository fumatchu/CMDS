#!/bin/bash
#Factory default the Server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date)
clear

#!/bin/bash
#Factory default the Server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date)
clear

mv /root/.meraki_mig/factory_default_action.sh /root
clear & /root/factory_default_action.sh
