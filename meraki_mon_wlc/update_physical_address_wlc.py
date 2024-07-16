# Import libraries
import requests
import time

# Define Meraki API key and organization ID
API_KEY = " "

# Define function to update device address
def update_device_address(serial, new_address, MOVE_MAP_MARKER, UPDATE_LOCATION):
  """Updates the address of a Meraki device.

  Args:
      serial: The serial number of the device.
      new_address: The new address to set for the device.
  """
  url = f"https://api.meraki.com/api/v1/devices/{serial}"
  headers = {"X-Cisco-Meraki-API-Key": API_KEY}
  payload = {"address": new_address, "updateLocation" : UPDATE_LOCATION, "moveMapMarker" : MOVE_MAP_MARKER}
  
  
  try:
    response = requests.put(url, headers=headers, json=payload)
    response.raise_for_status()
    print(f"Successfully updated address for device {serial}")
  except requests.exceptions.RequestException as e:
    print(f"Error updating device {serial}: {e}")

# Load list of serial numbers from a file (modify as needed)
serial_numbers_file = "/root/.meraki_mon_wlc/wlc_serials.txt"
with open(serial_numbers_file, "r") as f:
  serial_numbers = [line.strip() for line in f.readlines()]

new_address = " "
# Define new address (replace with your desired address)
MOVE_MAP_MARKER = True
UPDATE_LOCATION = True

# Update address for each device
for serial in serial_numbers:
  update_device_address(serial, new_address, MOVE_MAP_MARKER, UPDATE_LOCATION)

print("Finished updating device addresses.")
time.sleep(4)
