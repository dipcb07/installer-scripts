#!/bin/sh
# Go Installer Script
# Securely downloads and installs the latest Go release on Linux.
# Usage: ./install-go.sh [version]
# Example: ./install-go.sh 1.25.1
# If no version is passed, latest version is installed automatically.

set -e

VERSION="$1"
if [ -z "$VERSION" ]; then
  echo ">> Fetching latest Go version..."
  VERSION=$(curl -s https://go.dev/VERSION?m=text | head -n 1 | sed 's/go//')
fi

GO_TARBALL="go${VERSION}.linux-amd64.tar.gz"
DOWNLOAD_URL="https://go.dev/dl/${GO_TARBALL}"

echo ">> Downloading Go ${VERSION}..."
curl -LO "$DOWNLOAD_URL"

echo ">> Removing old Go installation..."
sudo rm -rf /usr/local/go

echo ">> Extracting Go ${VERSION}..."
sudo tar -C /usr/local -xzf "$GO_TARBALL"

echo ">> Cleaning up..."
rm -f "$GO_TARBALL"

PROFILE="$HOME/.profile"
if ! grep -q '/usr/local/go/bin' "$PROFILE"; then
  echo ">> Adding Go to PATH in $PROFILE"
  echo 'export PATH=$PATH:/usr/local/go/bin' >> "$PROFILE"
fi

echo ">> Applying PATH changes..."
export PATH=$PATH:/usr/local/go/bin

echo ">> Verifying installation..."
go version

echo ">> Done! Restart your terminal or run 'source ~/.profile' to refresh PATH."
