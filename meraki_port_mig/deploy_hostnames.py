import requests
import time
# Replace with your Meraki API key
API_KEY = 

# Replace with the path to your hostname file
HOSTNAME_FILE = "/root/.meraki_port_mig/hostnames.txt"


def update_hostname(serial, new_hostname):
    """Updates the hostname of a Meraki switch.

    Args:
        serial (str): The serial number of the switch.
        new_hostname (str): The new hostname for the switch.
    """
    url = f"https://api.meraki.com/api/v1/devices/{serial}"
    headers = {"X-Cisco-Meraki-API-Key": API_KEY, "Content-Type": "application/json"}
    new_config = {"name": new_hostname}
    response = requests.put(url, headers=headers, json=new_config)

    try:
        response = requests.put(url, headers=headers, json=new_config)
        response.raise_for_status()
        print(f"Successfully updated hostname for device {serial} to {new_hostname}")
    except requests.exceptions.RequestException as e:
        print(f"Error updating hostname for device {serial}: {e}")


def main():
    """Reads hostnames from a file and updates Meraki switches."""

    try:
        with open(HOSTNAME_FILE, "r") as f:
            for line in f:
                serial, new_hostname = line.strip().split(",")
                update_hostname(serial.strip(), new_hostname.strip())
    except FileNotFoundError:
        print(f"Error: File {HOSTNAME_FILE} not found")


if __name__ == "__main__":
    main()
time.sleep(1)