import meraki



API_KEY = " "

# Initialize the Meraki dashboard client
dashboard = meraki.DashboardAPI(api_key)

# Function to select an organization
def select_organization():
    organizations = dashboard.organizations.getOrganizations()
    print("Organizations:")
    for i, org in enumerate(organizations):
        print(f"{i + 1}: {org['name']}")
    org_index = int(input("Select an organization by number: ")) - 1
    return organizations[org_index]['id']

# Function to create a new network
def create_network(org_id):
    name = input("Enter the name of the new network: ")
    print ("Please see the following link for approved Timezones")
    print ("https://en.wikipedia.org/wiki/List_of_tz_database_time_zones")
    time_zone = input("Enter the time zone (e.g., 'America/Los_Angeles'): ")

    try:
        new_network = dashboard.organizations.createOrganizationNetwork(
            organizationId=org_id,
            name=name,
            timeZone=time_zone,
            productTypes=['switch']
        )
        print("New network created successfully:", new_network)
    except meraki.APIError as e:
        print(f"An error occurred: {e}")

# Main script
if __name__ == "__main__":
    org_id = select_organization()
    create_network(org_id)
