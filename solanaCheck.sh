#!/bin/bash
#set -x -e

# Check if Solana is installed
if command -v solana > /dev/null; then

  echo "Solana is installed"
  # Check if Solana is in the PATH
  if [[ ":$PATH:" == *":/path/to/solana/binary:"* ]]; then
  echo "Solana is in the PATH"
  chmod +x nodeJs.sh solana.sh
  echo "Scripts are now executable"
  echo "Run Scripts"
  /bin/bash nodeJs.sh

  else
  echo "Solana is not in the PATH"
  # Add Solana to PATH in ~/.bashrc
  echo 'export PATH=$PATH:/path/to/solana/binary' >> ~/.bashrc
  source ~/.bashrc
  #Change the permissions on the scripts to make them executable
  chmod +x nodeJs.sh solana.sh
  echo "Scripts are now executable"
  echo "Run Scripts"
  /bin/bash nodeJs.sh
  fi

else
  echo "Solana is not installed"
fi




