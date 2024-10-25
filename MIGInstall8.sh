#!/bin/bash
#Meraki-Mig.sh
#This script installs the Meraki migration server 
clear
dnf -y install net-tools dmidecode
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
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

if [ "$DETECTIP" = "ipv4.method:                            auto" ]; then
  echo ${RED}"Interface $INTERFACE is using DHCP${TEXTRESET}"
read -p "Please provide a static IP address in CIDR format (i.e 192.168.24.2/24): " IPADDR
  while [ -z "$IPADDR" ]; do
    echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
    read -p "Please provide a static IP address in CIDR format (i.e 192.168.24.2/24): " IPADDR
  done
  while [[ ! $IPADDR =~ ^$n(\.$n){3}/$m$ ]]; do
    read -p ${RED}"The entry is not in valid CIDR notation. Please Try again:${TEXTRESET} " IPADDR
done
  read -p "Please Provide a Default Gateway Address: " GW
  while [ -z "$GW" ]; do
    echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
    read -p "Please Provide a Default Gateway Address: " GW
  done
  read -p "Please provide the FQDN for this machine: " HOSTNAME
  while [ -z "$HOSTNAME" ]; do
    echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
    read -p "Please provide the FQDN for this machine: " HOSTNAME
  done
  read -p "Please provide an upstream DNS IP for resolution: " DNSSERVER
  while [ -z "$DNSSERVER" ]; do
    echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
    read -p "Please provide an upstream DNS IP for resolution: " DNSSERVER
  done
  read -p "Please provide the domain search name: " DNSSEARCH
  while [ -z "$DNSSEARCH" ]; do
    echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
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
  read -p "Press Enter to Continue"
  nmcli con mod $INTERFACE ipv4.address $IPADDR
  nmcli con mod $INTERFACE ipv4.gateway $GW
  nmcli con mod $INTERFACE ipv4.method manual
  nmcli con mod $INTERFACE ipv4.dns-search $DNSSEARCH
  nmcli con mod $INTERFACE ipv4.dns $DNSSERVER
  hostnamectl set-hostname $HOSTNAME

  cat <<EOF
The System must reboot for the changes to take effect.
${RED}Please log back in as root.${TEXTRESET}
The installer will continue when you log back in.
If using SSH, please use the IP Address: $IPADDR

EOF
  read -p "Press Enter to Continue"
  clear
  echo "/root/MIGInstaller/MIGInstall8.sh" >>/root/.bash_profile
  reboot
  exit
else
  echo ${GREEN}"Interface $INTERFACE is using a static IP address ${TEXTRESET}"
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

  read -p "Please provide the appropriate network scope in CIDR format (i.e 192.168.0.0/16) to allow NTP for clients: " NTPCIDR
  while [ -z "$NTPCIDR" ]; do
    echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
     read -p "Please provide the appropriate network scope in CIDR format (i.e 192.168.0.0/16) to allow NTP for clients: " NTPCIDR
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

  read -p "Please provide the beginning IP address in the lease range (based on the network $SUBNETNETWORK): " DHCPBEGIP
  while [ -z "$DHCPBEGIP" ]; do
    echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
    read -p "Please provide the beginning IP address in the lease range (based on the network $SUBNETNETWORK): " DHCPBEGIP
  done

  read -p "Please provide the ending IP address in the lease range (based on the network $SUBNETNETWORK): " DHCPENDIP
  while [ -z "$DHCPENDIP" ]; do
    echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
    read -p "Please provide the ending IP address in the lease range (based on the network $SUBNETNETWORK): " DHCPENDIP
  done

 read -p "Please provide the netmask for clients: " DHCPNETMASK
  while [ -z "$DHCPNETMASK" ]; do
    echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
    read -p "Please provide the default netmask for clients: " DHCPNETMASK
  done
  
  read -p "Please provide the default gateway for clients: " DHCPDEFGW
  while [ -z "$DHCPDEFGW" ]; do
    echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
    read -p "Please provide the default gateway for clients: " DHCPDEFGW
  done

  read -p "Please provide a description for this subnet: " SUBNETDESC
  while [ -z "$SUBNETDESC" ]; do
    echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
     read -p "Please provide a description for this subnet: " SUBNETDESC
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
dnf -y install iptraf-ng expect tar nmap cockpit cockpit-navigator cockpit-storaged dialog bc ntsysv at nano tftp-server gcc openssl-devel bzip2-devel libffi-devel zlib-devel wget make
#Install Python 3.10
clear
cat << EOF
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
pip3.10 install meraki
pip3.10 install requests
pip3.10 install --upgrade autopep8
pip3.10 install pandas

#Build tftp-server
\cp -f /usr/lib/systemd/system/tftp.service /etc/systemd/system/tftp-server.service
\cp -f /usr/lib/systemd/system/tftp.socket /etc/systemd/system/tftp-server.socket

sed -i '/Requires/c\Requires=tftp-server.socket' /etc/systemd/system/tftp-server.service
sed -i '/ExecStart/c\ExecStart=/usr/sbin/in.tftpd -c -p -s /var/lib/tftpboot' /etc/systemd/system/tftp-server.service
mkdir /var/lib/tftpboot/images
mkdir /var/lib/tftpboot/wlc
mkdir /var/lib/tftpboot/mon_switch
mkdir /var/lib/tftpboot/mig_switch

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
chmod 700 -R /root/.meraki_mig
chmod 700 -R /root/.meraki_mon_wlc
chmod 700 -R /root/.meraki_mon_switch
mv /root/.meraki_mig/meraki_migration /usr/sbin/



#Add DHCP Module
mv /root/MIGInstaller/.servman /root
chmod 700 -R /root/.servman

# Mr. M
chmod 700 /root/.meraki_mig/.logo
chmod 700 /root/.meraki_mon_wlc/.logo
chmod 700 /root/.meraki_mon_switch/.logo

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
