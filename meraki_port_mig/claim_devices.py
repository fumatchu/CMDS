import meraki
import os

# Replace with your API key
API_KEY = 
file_path = "/root/.meraki_port_mig/switch_serials.txt"

# Initialize the Meraki Dashboard API client
dashboard = meraki.DashboardAPI(API_KEY)

def list_organizations(api_key):
    try:
        # Fetch the list of organizations
        organizations = dashboard.organizations.getOrganizations()
        if organizations:
            print("Organizations:")
            for idx, org in enumerate(organizations, start=1):
                print(f"{idx}. ID: {org['id']}, Name: {org['name']}")
            return organizations
        else:
            print("No organizations found.")
            return None

    except meraki.exceptions.APIError as e:
        print(f"An error occurred: {e}")
        return None

    # Ensure to handle any other exceptions that may occur
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        return None

def select_organization(organizations):
    if not organizations:
        return None

    while True:
        try:
            selection = int(input("Enter the number of the organization you want to select: "))
            if 1 <= selection <= len(organizations):
                selected_org = organizations[selection - 1]
                return selected_org
            else:
                print("Invalid selection. Please select a number from the list.")
        except ValueError:
            print("Invalid input. Please enter a valid number.")

def list_networks(api_key, org_id):
    try:
        # Fetch the list of networks in the organization
        networks = dashboard.organizations.getOrganizationNetworks(org_id)

        if networks:
            print(f"\nNetworks in organization ID {org_id}:")
            for idx, network in enumerate(networks, start=1):
                print(f"{idx}. ID: {network['id']}, Name: {network['name']}")
            return networks
        else:
            print("No networks found in the organization.")
            return None

    except meraki.exceptions.APIError as e:
        print(f"An error occurred: {e}")
        return None

    # Ensure to handle any other exceptions that may occur
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        return None

def select_network(networks):
    if not networks:
        return None

    while True:
        try:
            selection = int(input("Enter the number of the network you want to select: "))
            if 1 <= selection <= len(networks):
                selected_network = networks[selection - 1]
                return selected_network
            else:
                print("Invalid selection. Please select a number from the list.")
        except ValueError:
            print("Invalid input. Please enter a valid number.")

def claim_devices_to_network(api_key, net_id, serials):
    try:
        # Claim devices to the selected network
        response = dashboard.networks.claimNetworkDevices(net_id, serials)
        print(f"Devices claimed successfully: {response}")
    except meraki.exceptions.APIError as e:
        print(f"An error occurred: {e}")

    # Ensure to handle any other exceptions that may occur
    except Exception as e:
        print(f"An unexpected error occurred: {e}")

def read_serials_from_file(file_path):
    if not os.path.exists(file_path):
        print(f"File not found: {file_path}")
        return None

    try:
        with open(file_path, 'r') as file:
            serials = [line.strip() for line in file.readlines() if line.strip()]
            return serials
    except Exception as e:
        print(f"An error occurred while reading the file: {e}")
        return None

# Main execution
organizations = list_organizations(API_KEY)
selected_organization = select_organization(organizations)

if selected_organization:
    networks = list_networks(API_KEY, selected_organization['id'])
    selected_network = select_network(networks)

    if selected_network:
        # Prompt user for the path to the serial numbers file
     #   file_path = input("Enter the path to the file containing the serial numbers: ")
        serials = read_serials_from_file(file_path)

        if serials:
            # Claim devices to the selected network
            claim_devices_to_network(API_KEY, selected_network['id'], serials)