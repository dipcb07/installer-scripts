#!/bin/sh
# Composer Installer Script
# Securely downloads and installs Composer globally on Linux
# Usage: ./install-composer.sh [version]
# Example: ./install-composer.sh 2.7.2

set -e

VERSION=${1:-latest}

echo ">> Fetching expected checksum..."
EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"

echo ">> Downloading installer..."
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

echo ">> Verifying installer..."
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then
    >&2 echo 'ERROR: Invalid installer checksum'
    rm composer-setup.php
    exit 1
fi

echo ">> Installing Composer ($VERSION)..."
php composer-setup.php --quiet --version=$VERSION
rm composer-setup.php

echo ">> Moving Composer to /usr/local/bin..."
sudo mv composer.phar /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer

echo ">> Done. Run 'composer --version' to check installation."
