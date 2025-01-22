#!/bin/bash

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root."
  exit 1
fi

# Define the DNS service
DNS_SERVICE="systemd-resolved"

# Check if the DNS service exists
echo "Checking if the $DNS_SERVICE service is installed..."
if systemctl list-units --type=service | grep -q "$DNS_SERVICE"; then
  echo "The $DNS_SERVICE service is installed."
else
  echo "The $DNS_SERVICE service is not installed on this system."
  exit 1
fi

# Check if the DNS service is active
echo "Checking if the $DNS_SERVICE service is running..."
if systemctl is-active --quiet $DNS_SERVICE; then
  echo "The $DNS_SERVICE service is running."
else
  echo "The $DNS_SERVICE service is not running. Attempting to start it..."
  if systemctl start $DNS_SERVICE; then
    echo "The $DNS_SERVICE service started successfully."
  else
    echo "Failed to start the $DNS_SERVICE service."
    exit 1
  fi
fi

# Reset the DNS cache
echo "Resetting the DNS cache..."
if systemctl restart $DNS_SERVICE; then
  echo "DNS cache successfully reset."
else
  echo "Failed to reset the DNS cache. Check the $DNS_SERVICE service."
  exit 1
fi

# Display current DNS settings
echo "Fetching current DNS settings..."
if command -v resolvectl &> /dev/null; then
  resolvectl status | grep "DNS Servers" -A 1
else
  echo "resolvectl command not found. Please ensure systemd-resolved is properly configured."
fi

echo "DNS cache reset process completed."

exit 0
