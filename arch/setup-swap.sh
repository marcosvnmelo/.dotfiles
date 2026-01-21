#!/usr/bin/bash

# Setup swap file (idempotent - only creates if it doesn't exist)
echo '*************************************************'
echo '*            Setting up swap file               *'
echo '*************************************************'

if [[ ! -f /swapfile ]]; then
  echo "Creating 16GB swap file..."
  sudo dd if=/dev/zero of=/swapfile bs=1G count=16 status=progress
  sudo chmod 0600 /swapfile
  sudo mkswap /swapfile
  sudo swapon /swapfile
  echo "Swap file created and enabled."
else
  echo "Swap file already exists. Ensuring it's enabled..."
  sudo swapon /swapfile 2>/dev/null || true
fi

# Add swap file to fstab if not already present
if ! grep -q "^/swapfile" /etc/fstab; then
  echo "Adding swap file to fstab..."
  echo "/swapfile none swap defaults 0 0" | sudo tee -a /etc/fstab > /dev/null
fi

# Verify swap configuration
echo "Current swap configuration:"
swapon --show
