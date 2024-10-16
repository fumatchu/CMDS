import requests
import csv

# Set up Meraki Dashboard API key and base URL
API_KEY = 'YOUR_MERAKI_API_KEY'  # Replace with your actual API key

BASE_URL = 'https://api.meraki.com/api/v1'

# Headers for the API requests
HEADERS = {
    'Content-Type': 'application/json',
    'X-Cisco-Meraki-API-Key': API_KEY
}

def read_ap_configs(file_path):
    with open(file_path, mode='r') as file:
        csv_reader = csv.DictReader(file)
        ap_configs = [row for row in csv_reader]
    return ap_configs

def claim_devices_to_network(network_id, serials):
    url = f'{BASE_URL}/networks/{network_id}/devices/claim'
    payload = {
        'serials': serials
    }
    response = requests.post(url, headers=HEADERS, json=payload)
    return response.status_code, response.text

def update_device_hostname(network_id, serial, hostname):
    url = f'{BASE_URL}/networks/{network_id}/devices/{serial}'
    payload = {
        'name': hostname
    }
    response = requests.put(url, headers=HEADERS, json=payload)
    return response.status_code, response.text

def main():
    # Path to the CSV file
    config_file_path = 'ap_config.csv'  # Replace with your CSV file path

    # Read AP configurations from CSV file
    ap_configs = read_ap_configs(config_file_path)

    # Network ID where the APs should be claimed
    network_id = 'YOUR_MERAKI_NETWORK_ID'  # Replace with your actual network ID
   
    # Claim all APs into the network
    serials = [ap_config['serial'] for ap_config in ap_configs]
    claim_status_code, claim_response_text = claim_devices_to_network(network_id, serials)
    print(f'Claiming Devices: Status Code: {claim_status_code}')
    print(f'Response: {claim_response_text}')

    if claim_status_code == 200:
        # Update the hostname of each claimed device
        for ap_config in ap_configs:
            serial = ap_config['serial']
            hostname = ap_config['name']
            update_status_code, update_response_text = update_device_hostname(network_id, serial, hostname)
            print(f'Updating Hostname for {serial}: Status Code: {update_status_code}')
            print(f'Response: {update_response_text}')
    else:
        print('Failed to claim devices. Hostname updates skipped.')

if __name__ == '__main__':
    main()
