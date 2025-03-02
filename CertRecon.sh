#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to fetch subdomains from crt.sh
fetch_subdomains() {
    domain=$1
    echo -e "${YELLOW}[+] Fetching subdomains from crt.sh for $domain...${NC}"
    
    crtsh_url="https://crt.sh/?q=%25.$domain&output=json"

    # Fetch the response
    response=$(curl -s "$crtsh_url")

    # Check if the response is empty
    if [[ -z "$response" ]]; then
        echo -e "${RED}[-] No response from crt.sh. Check your internet connection or try again later.${NC}"
        exit 1
    fi

    # Validate if the response contains JSON data
    if ! echo "$response" | jq empty > /dev/null 2>&1; then
        echo -e "${RED}[-] crt.sh returned an invalid response. Possible rate-limiting or service issue.${NC}"
        exit 1
    fi

    # Extract subdomains
    subdomains=$(echo "$response" | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u)

    if [[ -z "$subdomains" ]]; then
        echo -e "${RED}[-] No subdomains found.${NC}"
        exit 1
    fi

    echo "$subdomains"
}

# Function to check the HTTP status of each subdomain
check_status() {
    subdomain=$1
    status_code=$(curl -o /dev/null -s -w "%{http_code}" --max-time 5 "http://$subdomain")

    # Output status based on response
    if [[ "$status_code" == "200" ]]; then
        echo -e "${GREEN}[+] $subdomain - Status: $status_code (OK)${NC}"
    elif [[ "$status_code" == "301" || "$status_code" == "302" ]]; then
        echo -e "${YELLOW}[!] $subdomain - Status: $status_code (Redirect)${NC}"
    elif [[ "$status_code" == "000" ]]; then
        echo -e "${RED}[-] $subdomain - No response / Unreachable${NC}"
    else
        echo -e "${RED}[-] $subdomain - Status: $status_code${NC}"
    fi
}

# Main function
main() {
    if [[ -z "$1" ]]; then
        echo -e "${RED}Usage: $0 <domain>${NC}"
        exit 1
    fi

    domain=$1
    subdomains=$(fetch_subdomains "$domain")

    echo -e "${YELLOW}[*] Checking HTTP status for found subdomains...${NC}"

    # Loop through each subdomain and check its status
    while read -r subdomain; do
        check_status "$subdomain" &
    done <<< "$subdomains"

    wait
}

# Run the script
main "$1"
