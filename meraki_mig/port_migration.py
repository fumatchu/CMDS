import requests
import json
import re

# Set up Meraki Dashboard API key and base URL
API_KEY = ' '  # Replace with your actual API key
BASE_URL = 'https://api.meraki.com/api/v1'

# Headers for the API requests
HEADERS = {
    'Content-Type': 'application/json',
    'X-Cisco-Meraki-API-Key': API_KEY
}

def read_cisco_config(file_path):
    with open(file_path, 'r') as file:
        config_data = file.read()
    return config_data

def parse_cisco_config(config_data):
    interfaces = {}
    current_interface = None

    for line in config_data.splitlines():
        if line.startswith("interface"):
            current_interface = line.split()[1]
            interfaces[current_interface] = {}
        elif line.strip().startswith("description"):
            description = line.strip().split("description")[1]
            interfaces[current_interface]['name'] = description
        elif line.strip().startswith("udld port aggressive"):
            interfaces[current_interface]['udld'] = "Enforce"
        elif line.strip().startswith("switchport access vlan"):
            vlan = int(line.strip().split()[-1])
            interfaces[current_interface]['vlan'] = vlan
            interfaces[current_interface]['type'] = "access"
        elif line.strip().startswith("switchport trunk native vlan"):
            vlan = int(line.strip().split()[-1])
            interfaces[current_interface]['vlan'] = vlan
            interfaces[current_interface]['type'] = "trunk"
        elif line.strip().startswith("switchport trunk allowed vlan"):
            allowed_vlans = line.strip().split("switchport trunk allowed vlan ")[1]
            interfaces[current_interface]['allowedVlans'] = allowed_vlans
            interfaces[current_interface]['type'] = "trunk"
        elif line.strip().startswith("switchport voice vlan"):
            voice_vlan = int(line.strip().split()[-1])
            interfaces[current_interface]['voiceVlan'] = voice_vlan
        elif line.strip().startswith("spanning-tree bpduguard enable"):
            interfaces[current_interface]['stpGuard'] = 'bpdu Guard'
        elif line.strip().startswith("spanning-tree guard loop"):
            interfaces[current_interface]['stpGuard'] = 'loop Guard'
        elif line.strip().startswith("spanning-tree guard root"):
            interfaces[current_interface]['stpGuard'] = 'root Guard'
        elif line.strip().startswith("speed"):
            speed = line.strip().split("speed 100")[1]
            interfaces[current_interface]['linkNegotiation'] = '100 Megabit (auto)'


    return interfaces

def update_meraki_switch(serial, port_id, port_config):
    url = f'{BASE_URL}/devices/{serial}/switch/ports/{port_id}'
    response = requests.put(url, headers=HEADERS, data=json.dumps(port_config))
    return response.status_code, response.text

def main():
    # Read Cisco configuration from file
    cisco_config_file_path = '/root/.meraki_mig/cisco_config.tmp'  # Replace with your config file path
    cisco_config = read_cisco_config(cisco_config_file_path)

    # Parse Cisco configuration
    interfaces = parse_cisco_config(cisco_config)

    # Update Meraki switch configuration
    meraki_serial = ' '  # Replace with your actual Meraki switch serial number

    for interface, config in interfaces.items():
        # Extract port number; assumes interface name format like GigabitEthernet1/0/1
        port_match = re.search(r'(\d+)/(\d+)/(\d+)', interface)
        if port_match:
            port_id = port_match.group(3)  # Get the third group (the port number)
            status_code, response_text = update_meraki_switch(meraki_serial, port_id, config)

            # Print the response
            print(f'Updating Port {port_id}: Status Code: {status_code}')
            print(f'Response: {response_text}')
        else:
            print(f'Could not extract port number from interface {interface}')

if __name__ == '__main__':
    main()
