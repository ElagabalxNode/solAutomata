#!/bin/bash
#set -x -e

#Check if Node.js is already installed
if command -v node &>/dev/null; then
echo "Node.js is already installed."
/bin/bash solana.sh
exit 0
fi

#Check if curl is installed
if ! command -v curl &>/dev/null; then
echo "Error: curl is not installed."
exit 1
fi

#Check if tar is installed
if ! command -v tar &>/dev/null; then
echo "Error: tar is not installed."
exit 1
fi

#Set the Node.js version to install
NODE_VERSION="14.15.4"

#Set the architecture
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
ARCH="x64"
else
ARCH="x86"
fi

#Set the OS
OS=$(uname -s)
if [ "$OS" = "Darwin" ]; then
OS="darwin"
else
OS="linux"
fi

#Download the Node.js binary
echo "Downloading Node.js $NODE_VERSION for $OS-$ARCH..."
curl -L "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-$OS-$ARCH.tar.gz" -o "node.tar.gz"

#Extract the binary
echo "Extracting the binary..."
tar xvzf "node.tar.gz"

#Move the binary to /usr/local/bin
echo "Installing the binary to /usr/local/bin..."
mv "node-v$NODE_VERSION-$OS-$ARCH/bin/node" "/usr/local/bin/node"

#Clean up
echo "Cleaning up..."
rm -rf "node-v$NODE_VERSION-$OS-$ARCH"
rm "node.tar.gz"

#Verify the installation
echo "Verifying the installation..."
if command -v node &>/dev/null; then
echo "Node.js $NODE_VERSION was successfully installed."
/bin/bash solana.sh
else
echo "Error: Node.js was not installed."
exit 1
fi

