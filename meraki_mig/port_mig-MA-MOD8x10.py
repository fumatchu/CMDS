import requests
import json
import re

# Set up Meraki Dashboard API key and base URL
API_KEY = " "  # Replace with your actual API key
BASE_URL = "https://api.meraki.com/api/v1"

# Headers for the API requests
HEADERS = {"Content-Type": "application/json", "X-Cisco-Meraki-API-Key": API_KEY}


def parse_cisco_config(config_data):
    interfaces = {}
    current_interface = None
    for line in config_data.splitlines():
        if line.startswith("interface"):
            current_interface = line.split()[1]
            interfaces[current_interface] = {}
        elif line.strip().startswith("description"):
            description = line.strip().split("description ")[1]
            interfaces[current_interface]["name"] = description
        elif line.strip().startswith("udld port aggressive"):
            interfaces[current_interface]["udld"] = "Enforce"
        elif line.strip().startswith("switchport access vlan"):
            vlan = int(line.strip().split()[-1])
            interfaces[current_interface]["vlan"] = vlan
            interfaces[current_interface]["type"] = "access"
        elif line.strip().startswith("switchport trunk native vlan"):
            vlan = int(line.strip().split()[-1])
            interfaces[current_interface]["vlan"] = vlan
            interfaces[current_interface]["type"] = "trunk"
        elif line.strip().startswith("switchport trunk allowed vlan"):
            allowed_vlans = line.strip().split("switchport trunk allowed vlan ")[1]
            interfaces[current_interface]["allowedVlans"] = allowed_vlans
            interfaces[current_interface]["type"] = "trunk"
        elif line.strip().startswith("switchport voice vlan"):
            voice_vlan = int(line.strip().split()[-1])
            interfaces[current_interface]["voiceVlan"] = voice_vlan
        elif line.strip().startswith("spanning-tree bpduguard enable"):
            interfaces[current_interface]["stpGuard"] = "bpdu Guard"
        elif line.strip().startswith("spanning-tree guard loop"):
            interfaces[current_interface]["stpGuard"] = "loop Guard"
        elif line.strip().startswith("spanning-tree guard root"):
            interfaces[current_interface]["stpGuard"] = "root Guard"

    return interfaces


def update_uplink_port(serial, port_id, port_config):
    url = f"{BASE_URL}/devices/{serial}/switch/ports/{port_id}"
    response = requests.put(url, headers=HEADERS, data=json.dumps(port_config))
    return response.status_code, response.text


def main():
    # Path to the Cisco configuration file
    cisco_config_file_path = "cisco_config.txt"  # Replace with your config file path

    # Read Cisco configuration from file
    try:
        with open(cisco_config_file_path, "r") as file:
            cisco_config = file.read()
    except FileNotFoundError:
        print(f"Error: File {cisco_config_file_path} does not exist.")
        return

    # Parse the Cisco configuration
    interfaces = parse_cisco_config(cisco_config)

    # Meraki Network ID and Device Serial Number
    serial = "Q5TD-2CTZ-PNSF"  # Replace with your actual switch serial number

    # Port IDs of the MA-MOD-10G ports to update (assuming ports 1 to 8)
    uplink_ports = [
        "1_MA-MOD-8X10G_1",
        "1_MA-MOD-8X10G_2",
        "1_MA-MOD-8X10G_3",
        "1_MA-MOD-8X10G_4",
        "1_MA-MOD-8X10G_5",
        "1_MA-MOD-8X10G_6",
        "1_MA-MOD-8X10G_7",
        "1_MA-MOD-8X10G_8",
    ]

    # Update the Meraki switch ports based on the parsed Cisco configuration
    for interface, config in interfaces.items():
        # Extract port number; assumes interface name format like TenGigabitEthernet1/0/1 or similar
        port_match = re.search(r"(\d+/\d+/\d+)", interface)
        if port_match:
            port_split = port_match.group(1).split("/")[
                -1
            ]  # Get the third part (the port number)
            port_id = f"1_MA-MOD-8X10G_{port_split}"
            if port_id in uplink_ports:
                status_code, response = update_uplink_port(serial, port_id, config)
                print(f"Updating Uplink Port {port_id}: Status Code: {status_code}")
                print(f"Response: {json.dumps(response, indent=2)}")
            else:
                print(
                    f"Interface {interface} does not match any of the NM-8-10G ports."
                )
        else:
            print(f"Could not extract port number from interface {interface}")


if __name__ == "__main__":
    main()
