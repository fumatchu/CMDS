#!/bin/bash
#Meraki-Mig.sh
#This script installs the Meraki migration server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
clear
#Check for Network Connectivity
echo "Checking for Internet Connectivity"
echo " "
sleep 3
# Function to check DNS resolution
check_dns_resolution() {
    local domain=$1
    ping -c 1 $domain &> /dev/null
    return $?
}

# Function to ping an address
ping_address() {
    local address=$1
    ping -c 1 $address &> /dev/null
    return $?
}

# Flag to track if any test fails
test_failed=false

# Check DNS resolution for google.com
echo "Checking DNS resolution for google.com via ping..."
if check_dns_resolution "google.com"; then
    echo "DNS resolution for google.com is successful."
else
    echo "DNS resolution for google.com failed."
    test_failed=true
fi

# Ping 8.8.8.8
echo "Trying to ping 8.8.8.8..."
if ping_address "8.8.8.8"; then
    echo "Successfully reached 8.8.8.8."
else
    echo "Cannot reach 8.8.8.8."
    test_failed=true
fi

# Provide final results summary
echo
echo "===== TEST RESULTS ====="
echo "DNS Resolution for google.com: $(if check_dns_resolution "google.com"; then echo "${GREEN}Passed"${TEXTRESET}; else echo "${RED}Failed"${TEXTRESET}; fi)"
echo "Ping to 8.8.8.8: $(if ping_address "8.8.8.8"; then echo "${GREEN}Passed"${TEXTRESET}; else echo "${RED}Failed"${TEXTRESET}; fi)"
echo "========================"
echo

# Prompt the user only if any test fails
if $test_failed; then
    read -p "One or more tests failed. Do you want to continue the script? (y/n): " user_input
    if [[ $user_input == "y" || $user_input == "Y" ]]; then
        echo "Continuing the script with failures"
        sleep 1
        # Place additional script logic here
    else
        echo "Please make sure that you have full Connectivty to the Internet Before Proceeding."
        exit 1
    fi
else
    echo "All tests passed successfully."
    sleep 3
    # Continue with the script or exit as needed
fi
clear
dnf -y install net-tools dmidecode
INTERFACE=$(nmcli | grep "connected to" | cut -d " " -f4)
DETECTIP=$(nmcli -f ipv4.method con show $INTERFACE)
FQDN=$(hostname)
IP=$(hostname -I)
DOMAIN=$(hostname | sed 's/^[^.:]*[.:]//' | sed -e 's/\(.*\)/\U\1/')
ADDOMAIN=$(hostname | sed 's/^[^.:]*[.:]//' | cut -d. -f1 | sed -e 's/\(.*\)/\U\1/')
REVERSE=$(echo "$IP" | {
  IFS=. read q1 q2 q3 q4
  echo "$q3.$q2.$q1"
})
MAJOROS=$(cat /etc/redhat-release | grep -Eo "[8]")
MINOROS=$(cat /etc/redhat-release | grep -Eo "[0-9]" | sed '1d')
USER=$(whoami)
DHCPNSNAME=$(hostname | sed 's/^[^.:]*[.:]//')

SUBNETNETWORK=$(echo "$IP" | {
  IFS=. read q1 q2 q3 q4
  echo "$q1.$q2.$q3.0"
})
NMCLIIP=$(nmcli | grep inet4 | cut -c8-)
HWKVM=$(dmidecode | grep -i -e manufacturer -e product -e vendor | grep KVM | cut -c16-)
HWVMWARE=$(dmidecode | grep -i -e manufacturer -e product -e vendor | grep Manufacturer | grep "VMware, Inc." | cut -c16- | cut -d , -f1)
n='([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])'
m='([0-9]|[12][0-9]|3[012])'

#Checking for user permissions
if [ "$USER" = "root" ]; then
  echo " "
else
  echo ${RED}"This program must be run as root ${TEXTRESET}"
  echo "Exiting"
fi
#Checking for version Information
if [ "$MAJOROS" = "8" ]; then
  echo " "
else
  echo ${RED}"Sorry, but this installer only works on Rocky 8.X ${TEXTRESET}"
  echo "Please upgrade to ${GREEN}Rocky 8.x${TEXTRESET}"
  echo "Exiting the installer..."
  exit
fi
clear
#Detect Static or DHCP (IF not Static, change it)
cat <<EOF
Checking for static IP Address
EOF
sleep 1s

if [ -z "$INTERFACE" ]; then
  "Usage: $0 <interface>"
  exit 1
fi

# Function to validate IP address in CIDR notation
validate_cidr() {
  local cidr=$1
  local n="(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])"
  local m="(3[0-2]|[1-2]?[0-9])"
  [[ $cidr =~ ^$n(\.$n){3}/$m$ ]]
}

# Function to validate an IP address in dotted notation
validate_ip() {
  local ip=$1
  local n="(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])"
  [[ $ip =~ ^$n(\.$n){3}$ ]]
}

# Function to validate FQDN
validate_fqdn() {
  local fqdn=$1
  [[ $fqdn =~ ^([a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$ ]]
}

if [ "$DETECTIP" = "ipv4.method:                            auto" ]; then
  while true; do
    echo -e "${RED}Interface $INTERFACE is using DHCP${TEXTRESET}"

    # Validate IPADDR
    read -p "Please provide a static IP address in CIDR format (i.e 192.168.24.2/24): " IPADDR
    while ! validate_cidr "$IPADDR"; do
      echo -e "${RED}The entry is not in valid CIDR notation. Please Try again${TEXTRESET}"
      read -p "Please provide a static IP address in CIDR format (i.e 192.168.24.2/24): " IPADDR
    done

    # Validate GW
    read -p "Please provide a Default Gateway Address: " GW
    while ! validate_ip "$GW"; do
      echo -e "${RED}The entry is not a valid IP address. Please Try again${TEXTRESET}"
      read -p "Please provide a Default Gateway Address: " GW
    done

    # Validate HOSTNAME
    read -p "Please provide the FQDN for this machine: " HOSTNAME
    while ! validate_fqdn "$HOSTNAME"; do
      echo -e "${RED}The entry is not a valid FQDN. Please Try again${TEXTRESET}"
      read -p "Please provide the FQDN for this machine: " HOSTNAME
    done

    # Validate DNSSERVER
    read -p "Please provide an upstream DNS IP for resolution: " DNSSERVER
    while ! validate_ip "$DNSSERVER"; do
      echo -e "${RED}The entry is not a valid IP address. Please Try again${TEXTRESET}"
      read -p "Please provide an upstream DNS IP for resolution: " DNSSERVER
    done

    # Validate DNSSEARCH
    read -p "Please provide the domain search name: " DNSSEARCH
    while [ -z "$DNSSEARCH" ]; do
      echo -e "${RED}The response cannot be blank. Please Try again${TEXTRESET}"
      read -p "Please provide the domain search name: " DNSSEARCH
    done

    clear
    cat <<EOF
The following changes to the system will be configured:
IP address: ${GREEN}$IPADDR${TEXTRESET}
Gateway: ${GREEN}$GW${TEXTRESET}
DNS Search: ${GREEN}$DNSSEARCH${TEXTRESET}
DNS Server: ${GREEN}$DNSSERVER${TEXTRESET}
HOSTNAME: ${GREEN}$HOSTNAME${TEXTRESET}

EOF

    # Ask the user to confirm the changes
    read -p "Are these settings correct? (y/n): " CONFIRM
    if [ "$CONFIRM" = "y" ] || [ "$CONFIRM" = "Y" ]; then
      nmcli con mod $INTERFACE ipv4.address $IPADDR
      nmcli con mod $INTERFACE ipv4.gateway $GW
      nmcli con mod $INTERFACE ipv4.method manual
      nmcli con mod $INTERFACE ipv4.dns-search $DNSSEARCH
      nmcli con mod $INTERFACE ipv4.dns $DNSSERVER
      hostnamectl set-hostname $HOSTNAME
      echo "/root/MIGInstaller/MIGInstall8.sh" >>/root/.bash_profile
      echo "The System must reboot for the changes to take effect."
      echo "${RED}Please log back in as root.${TEXTRESET}"
      echo "The installer will continue when you log back in."
      echo "If using SSH, please use the IP Address: $IPADDR"
      echo "${RED}Rebooting${TEXTRESET}"
      sleep 2
      reboot
      break
    else
      echo -e "${RED}Reconfiguring Interface${TEXTRESET}"
      sleep 2
      clear
    fi
  done
else
  echo -e "${GREEN}Interface $INTERFACE is using a static IP address${TEXTRESET}"
  sleep 2
fi
clear
if [ "$FQDN" = "localhost.localdomain" ]; then
  cat <<EOF
${RED}This system is still using the default hostname (localhost.localdomain)${TEXTRESET}

EOF
  read -p "Please provide a valid FQDN for this machine: " HOSTNAME
  while [ -z "$HOSTNAME" ]; do
    echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
    read -p "Please provide a valid FQDN for this machine: " HOSTNAME
  done
  hostnamectl set-hostname $HOSTNAME
  cat <<EOF
The System must reboot for the changes to take effect.
${RED}Please log back in as root.${TEXTRESET}
The installer will continue when you log back in.
If using SSH, please use the IP Address: ${NMCLIIP}

EOF
  read -p "Press Enter to Continue"
  clear
  echo "/root/MIGInstaller/MIGInstall8.sh" >>/root/.bash_profile
  reboot
  exit

fi

cat <<EOF
*********************************************
${GREEN}This will Install CMDS (Catalyst to Meraki Deployment Server)${TEXTRESET}

Checklist:
Before the Installer starts, please make sure you have the following information

    1. ${YELLOW}An NTP Subnet${TEXTRESET} (Optional) for your clients. This server will provide synchronized time
    2. The ${YELLOW}beginning and ending lease range${TEXTRESET} for DHCP (optional)
    3. The ${YELLOW}client default gateway IP Address${TEXTRESET} for the DHCP Scope (optional)
    4. A ${YELLOW}Friendly name${TEXTRESET} as a description to the DHCP scope created (optional)


*********************************************
EOF
read -p "Press Enter to Continue or Ctrl-C to exit the Installer"
clear

#OPTIONAL NTP Installation
cat <<EOF
${GREEN}NTP Server Setup${TEXTRESET}

This server can be an NTP server to service clients.
The installer will prompt you to create a default client ACL

EOF

read -r -p "Would you like to enable NTP to Service clients? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  echo ${GREEN}"Configuring NTP Server${TEXTRESET}"
  sleep 1
  firewall-cmd --zone=public --add-service ntp --permanent
  clear

 # Function to validate CIDR format
isValidCIDR() {
    local cidr=$1
    # Regular expression to match valid IPv4 CIDR notation
    [[ $cidr =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}/([0-9]|[12][0-9]|3[0-2])$ ]] || return 1

    # Split the IP and prefix length
    IFS=/ read -r ip prefix <<< "$cidr"
    
    # Check if each octet of the IP is less than or equal to 255
    IFS=. read -r o1 o2 o3 o4 <<< "$ip"
    (( o1 <= 255 && o2 <= 255 && o3 <= 255 && o4 <= 255 )) || return 1

    return 0
}

# Prompt user for CIDR input and validate
while true; do
    read -p "Please provide the appropriate network scope in CIDR format (i.e 192.168.0.0/16) to allow NTP for clients: " NTPCIDR
    if [ -z "$NTPCIDR" ]; then
        echo -e "${RED}The response cannot be blank. Please try again.${TEXTRESET}"
    elif ! isValidCIDR "$NTPCIDR"; then
        echo -e "${RED}Invalid CIDR format. Please provide a valid CIDR (e.g., 192.168.0.0/16).${TEXTRESET}"
    else
        break
    fi
done

  sed -i "/#allow /c\allow $NTPCIDR" /etc/chrony.conf

  systemctl restart chronyd

fi

clear

#OPTIONAL DHCP Installation
cat <<EOF
${GREEN}DHCP Server Setup${TEXTRESET}

This server can be a DHCP server to service clients.
The installer will prompt you to create a default declaration for its interface
If you want to add additional scopes, use Server Management after installation

EOF

read -r -p "Would you like to install/enable DHCP and create a default scope? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  echo ${GREEN}"Installing DHCP Server${TEXTRESET}"
  sleep 1
  dnf -y install dhcp-server
  firewall-cmd --zone=public --add-service dhcp --permanent
  clear

  # Function to validate IP address format
isValidIP() {
    local ip=$1
    # Regular expression to match valid IPv4 address
    [[ $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] || return 1

    # Check if each octet is less than or equal to 255
    IFS=. read -r o1 o2 o3 o4 <<< "$ip"
    (( o1 <= 255 && o2 <= 255 && o3 <= 255 && o4 <= 255 )) || return 1

    return 0
}

# Function to validate netmask format
isValidNetmask() {
    local netmask=$1
    # List of valid netmask values
    local valid_netmasks=(
        "255.255.255.255" "255.255.255.254" "255.255.255.252" "255.255.255.248"
        "255.255.255.240" "255.255.255.224" "255.255.255.192" "255.255.255.128"
        "255.255.255.0"   "255.255.254.0"   "255.255.252.0"   "255.255.248.0"
        "255.255.240.0"   "255.255.224.0"   "255.255.192.0"   "255.255.128.0"
        "255.255.0.0"     "255.254.0.0"     "255.252.0.0"     "255.248.0.0"
        "255.240.0.0"     "255.224.0.0"     "255.192.0.0"     "255.128.0.0"
        "255.0.0.0"       "254.0.0.0"       "252.0.0.0"       "248.0.0.0"
        "240.0.0.0"       "224.0.0.0"       "192.0.0.0"       "128.0.0.0"
        "0.0.0.0"
    )
    
    for valid in "${valid_netmasks[@]}"; do
        if [[ "$netmask" == "$valid" ]]; then
            return 0
        fi
    done

    return 1
}

# Prompt user for beginning IP address and validate
while true; do
    read -p "Please provide the beginning IP address in the lease range (based on the network $SUBNETNETWORK): " DHCPBEGIP
    if [ -z "$DHCPBEGIP" ]; then
        echo -e "${RED}The response cannot be blank. Please try again.${TEXTRESET}"
    elif ! isValidIP "$DHCPBEGIP"; then
        echo -e "${RED}Invalid IP format. Please provide a valid IP address.${TEXTRESET}"
    else
        break
    fi
done

# Prompt user for ending IP address and validate
while true; do
    read -p "Please provide the ending IP address in the lease range (based on the network $SUBNETNETWORK): " DHCPENDIP
    if [ -z "$DHCPENDIP" ]; then
        echo -e "${RED}The response cannot be blank. Please try again.${TEXTRESET}"
    elif ! isValidIP "$DHCPENDIP"; then
        echo -e "${RED}Invalid IP format. Please provide a valid IP address.${TEXTRESET}"
    else
        break
    fi
done

# Prompt user for netmask and validate
while true; do
    read -p "Please provide the netmask for clients: " DHCPNETMASK
    if [ -z "$DHCPNETMASK" ]; then
        echo -e "${RED}The response cannot be blank. Please try again.${TEXTRESET}"
    elif ! isValidNetmask "$DHCPNETMASK"; then
        echo -e "${RED}Invalid netmask format. Please provide a valid netmask (e.g., 255.255.255.0).${TEXTRESET}"
    else
        break
    fi
done

# Prompt user for default gateway and validate
while true; do
    read -p "Please provide the default gateway for clients: " DHCPDEFGW
    if [ -z "$DHCPDEFGW" ]; then
        echo -e "${RED}The response cannot be blank. Please try again.${TEXTRESET}"
    elif ! isValidIP "$DHCPDEFGW"; then
        echo -e "${RED}Invalid IP format. Please provide a valid IP address.${TEXTRESET}"
    else
        break
    fi
done

# Prompt user for subnet description and ensure it's not blank
while true; do
    read -p "Please provide a description for this subnet: " SUBNETDESC
    if [ -z "$SUBNETDESC" ]; then
        echo -e "${RED}The response cannot be blank. Please try again.${TEXTRESET}"
    else
        break
    fi
done

  #Configure DHCP
  mv /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.orig

  cat <<EOF >/etc/dhcp/dhcpd.conf

authoritative;
allow unknown-clients;
option ntp-servers ${IP};
option time-servers ${IP};
option domain-name-servers ${IP};
option domain-name "${DHCPNSNAME}";
option domain-search "${DHCPNSNAME}";


#$SUBNETDESC
subnet ${SUBNETNETWORK} netmask ${DHCPNETMASK} {
        range ${DHCPBEGIP} ${DHCPENDIP};
        option subnet-mask ${DHCPNETMASK};
        option routers ${DHCPDEFGW};
}
EOF

  systemctl enable dhcpd
  systemctl start dhcpd

fi

clear

#OPTIONAL DNS Installation
cat <<EOF
${GREEN}DNS Server Setup${TEXTRESET}

This server can be a DNS server to service clients (The switches need name resolution to contact the Meraki cloud)
EOF

read -r -p "Would you like to install/enable DNS? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  echo ${GREEN}"Installing DNS Server${TEXTRESET}"
  sleep 1
  dnf -y install bind bind-utils
  firewall-cmd --zone=public --add-service dns --permanent
  firewall-cmd --complete-reload

  sed -i '/127.0.0.1/c\        listen-on port 53 { 127.0.0.1; any; };' /etc/named.conf
  sed -i '/localhost; /c\        allow-query     { localhost; any; };' /etc/named.conf

  systemctl enable named
  systemctl start named
fi

clear

#Checking for VM platform-Install client
echo ${GREEN}"Installing VMGuest${TEXTRESET}"
if [ "$HWKVM" = "KVM" ]; then
  echo ${GREEN}"KVM Platform detected ${TEXTRESET}"
  echo "Installing qemu-guest-agent"
  sleep 1
  dnf -y install qemu-guest-agent
else
  echo "Not KVM Platform"
fi

#Checking for VM platform-Install client
if [ "$HWVMWARE" = "VMware" ]; then
  echo ${GREEN}"VMWARE Platform detected ${TEXTRESET}"
  echo "Installing open-vm-tools"
  sleep 1
  dnf -y install open-vm-tools
else
  echo "Not VMware Platform"
fi
clear

#If this server got DHCP, and there is an NTP server option, we must change it to a pool
sed -i '/server /c\pool 2.rocky.pool.ntp.org iburst' /etc/chrony.conf
systemctl restart chronyd
clear
echo ${RED}"Synchronizing time, Please wait${TEXTRESET}"
sleep 10s
clear
chronyc tracking
cat <<EOF
${GREEN}We should be syncing time${TEXTRESET}

The Installer will continue in a moment or Press Ctrl-C to Exit
EOF
sleep 5s
clear

#Apply Firewall Rules
cat <<EOF
Updating Firewall Rules
EOF

firewall-cmd --complete-reload
systemctl restart firewalld
clear
echo ${GREEN}"These are the services/ports now open on the server${TEXTRESET}"
firewall-cmd --list-all
echo "The Installer will continue in a moment or Press Ctrl-C to Exit"
sleep 8s
clear
cat <<EOF
${GREEN}Updating Server${TEXTRESET}
${YELLOW}This may take approximately 5-10 minutes${TEXTRESET}
EOF
sleep 4s

# Initial build
dnf -y install epel-release
dnf -y install dnf-plugins-core
dnf config-manager --set-enabled powertools
dnf -y update
curl -sSL https://repo.45drives.com/setup -o setup-repo.sh
sudo bash setup-repo.sh
dnf -y install iptraf-ng expect tar nmap cockpit cockpit-navigator cockpit-storaged dialog dos2unix bc ntsysv at nano tftp-server gcc openssl-devel bzip2-devel libffi-devel zlib-devel wget make
#Install Python 3.10
clear
cat <<EOF
${YELLOW}Installing Required Python Elements${TEXTRESET}
Please wait...
EOF
sleep 2
clear
cd /root
wget https://www.python.org/ftp/python/3.10.5/Python-3.10.5.tgz
tar xzf Python-3.10.5.tgz
cd Python-3.10.5
./configure --enable-optimizations
make -j 4
nproc
make altinstall
mv /root/Python-3.10.5/ /opt/
rm -f /root/Python*
alias python3=/opt/Python-3.10.5/python
clear
/usr/local/bin/python3.10 -m pip install --upgrade pip
pip3.10 install --root-user-action=ignore meraki
pip3.10 install --root-user-action=ignore requests
pip3.10 install --root-user-action=ignore --upgrade autopep8
pip3.10 install --root-user-action=ignore pandas

#Build tftp-server
\cp -f /usr/lib/systemd/system/tftp.service /etc/systemd/system/tftp-server.service
\cp -f /usr/lib/systemd/system/tftp.socket /etc/systemd/system/tftp-server.socket

sed -i '/Requires/c\Requires=tftp-server.socket' /etc/systemd/system/tftp-server.service
sed -i '/ExecStart/c\ExecStart=/usr/sbin/in.tftpd -c -p -s /var/lib/tftpboot' /etc/systemd/system/tftp-server.service
mkdir /var/lib/tftpboot/images
mkdir /var/lib/tftpboot/wlc
mkdir /var/lib/tftpboot/mon_switch
mkdir /var/lib/tftpboot/mig_switch
mkdir /var/lib/tftpboot/port_switch

chmod 777 -R /var/lib/tftpboot
firewall-cmd --permanent --add-service tftp
firewall-cmd --complete-reload
systemctl daemon-reload
systemctl enable --now tftp-server.socket

#Enable cockpit
systemctl enable --now cockpit.socket

#Update /etc/issue so we can see the hostname and IP address Before logging in
rm -r -f /etc/issue
touch /etc/issue
cat <<EOF >/etc/issue
\S
Kernel \r on an \m
Hostname: \n
IP Address: \4
EOF

#Put meraki_migration in the path
mv /root/MIGInstaller/meraki_mig /root/.meraki_mig
#Catalyst Wireless Monitoring
mv /root/MIGInstaller/meraki_mon_wlc /root/.meraki_mon_wlc
#Catalyst Wireless Monitoring
mv /root/MIGInstaller/meraki_mon_switch /root/.meraki_mon_switch
#Catalyst Port Migration
mv /root/MIGInstaller/meraki_port_mig /root/.meraki_port_mig
mkdir /root/.meraki_mig/logs
mkdir /root/.meraki_mon_wlc/logs
mkdir /root/.meraki_mon_switch/logs
mkdir /root/.meraki_port_mig/logs
mkdir /root/.meraki_port_mig/tmp

chmod 700 -R /root/.meraki_mig
chmod 700 -R /root/.meraki_mon_wlc
chmod 700 -R /root/.meraki_mon_switch
chmod 700 -R /root/.meraki_port_mig

mv /root/.meraki_mig/meraki_migration /usr/sbin/

#Add DHCP Module
mv /root/MIGInstaller/.servman /root
chmod 700 -R /root/.servman

#Create Directory for Active Templates
mkdir /root/.meraki_mig/templates/active

#Create linked folder for linked template option
mkdir /root/.meraki_mig/templates/linked

#Create Folder for imported port configurations into templates for pre-existing switches
mkdir /root/.meraki_mig/templates/already_installed
mkdir /root/.meraki_mig/templates/already_installed/active
mkdir /root/.meraki_mig/templates/already_installed/linked

#Create Switch files to modify for already configured switches
touch /root/.meraki_mig/templates/already_installed/switch_serials_24.txt
touch /root/.meraki_mig/templates/already_installed/switch_serials_48.txt

#Bracketed pasting...yuck!
sed -i '8i set enable-bracketed-paste off' /etc/inputrc

#Archive Folder in root directory
mkdir /root/archive
mkdir /root/archive/CatalystConfigurations
#Add Meraki_migration to root login

echo "/usr/sbin/meraki_migration" >>/root/.bash_profile

#Add Python 3.10 to path
echo "alias python3=/opt/Python-3.10.5/python" >>/root/.bash_profile

#Cleanup Install Files
sed -i '/MIGInstall8.sh/d' /root/.bash_profile
rm -r -f /root/MIG*
rm -r -f /root/mig*
rm -r -f *.tgz
dnf clean all
clear
cat <<EOF
${GREEN}
********************************
  Server Installation Complete
********************************
${TEXTRESET}

The server will reboot now
EOF
echo " "
read -p "Press Enter to Continue"
echo ${RED}"Rebooting${TEXTRESET}"
sleep 1
reboot
