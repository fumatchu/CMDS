# Import libraries
import requests
import time
# Replace with your Meraki Dashboard API key

API_KEY = " "

# Define file path for WLC serial numbers
SERIAL_FILE = "/root/.meraki_mon_wlc/wlc_serials.txt"

# Function to get organizations
def get_organizations():
  url = "https://api.meraki.com/api/v1/organizations"
  headers = {"X-Cisco-Meraki-API-Key": API_KEY}
  response = requests.get(url, headers=headers)

  if response.status_code == 200:
    organizations = response.json()
    return organizations
  else:
    print(f"Error getting organizations: {response.text}")
    return None

# Function to display organization list
def display_organizations(orgs):
  if orgs:
    for idx, org in enumerate(orgs):
      print(f"{idx+1}. {org['name']} ({org['id']})")
  else:
    print("No organizations found in your dashboard.")

# Function to claim devices in batch
def claim_devices_batch(organization_id, serials):
  url = f"https://api.meraki.com/api/v1/organizations/{organization_id}/inventory/claim"
  headers = {"X-Cisco-Meraki-API-Key": API_KEY, "Content-Type": "application/json"}
  data = {"serials": serials}
  response = requests.post(url, headers=headers, json=data)

  if response.status_code == 200:
    print("Devices claimed successfully!")
  else:
    print(f"Error claiming devices: {response.text}")

# Read switch serial numbers from file
try:
  with open(SERIAL_FILE, "r") as file:
    serials = [line.strip() for line in file.readlines()]
except FileNotFoundError:
  print(f"Error: File '{SERIAL_FILE}' not found!")
  exit()

# Get organizations and display list
organizations = get_organizations()

if organizations:
  display_organizations(organizations)

  # User selection for organization
  while True:
    try:
      choice = int(input("Select organization by number (or 0 to exit): "))
      if 0 <= choice <= len(organizations):
        break
      else:
        print("Invalid choice. Please enter a number between 0 and", len(organizations))
    except ValueError:
      print("Invalid input. Please enter a number.")

  if choice > 0:
    selected_org = organizations[choice - 1]
    selected_org_id = selected_org["id"]
    print(f"\nSelected organization: {selected_org['name']} ({selected_org_id})")

    # Claim devices in batch
    claim_devices_batch(selected_org_id, serials)

  else:
    print("Exiting script...")

print("Claiming process complete!")

time.sleep(5)
