# Import libraries
import requests

# Replace with your Meraki Dashboard API key

API_KEY = 
# Define file path for switch serial numbers
SERIAL_FILE = "/root/.meraki_mig/switch_serials_48.txt"

# New VLAN and Voice VLAN IDs
NEW_VLAN =
NEW_VOICE_VLAN =
SWITCH_TYPE = "access"

# Function to update a single port
def update_port(switch_serial, port_id):
  url = f"https://api.meraki.com/api/v1/devices/{switch_serial}/switch/ports/{port_id}"
  headers = {"X-Cisco-Meraki-API-Key": API_KEY, "Content-Type": "application/json"}
  new_config = {"type": SWITCH_TYPE, "vlan": NEW_VLAN, "voiceVlan": NEW_VOICE_VLAN}
  response = requests.put(url, headers=headers, json=new_config)

  if response.status_code == 200:
    print(f"Switch {switch_serial} - Port {port_id} updated successfully!")
  else:
    print(f"Error updating switch {switch_serial} port {port_id}: {response.text}")

# Read switch serial numbers from file
try:
  with open(SERIAL_FILE, "r") as file:
    switches = [line.strip() for line in file.readlines()]
except FileNotFoundError:
  print(f"Error: File '{SERIAL_FILE}' not found!")
  exit()

# Update ports on all switches
for switch_serial in switches:
  # Update ports 1 to 24 (modify loop as needed)
  for port_id in range(1, 49):
    update_port(switch_serial, port_id)

print("Update complete!")
