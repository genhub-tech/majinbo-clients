#!/bin/bash

RELEASE_URL_BASE="https://github.com/genhub-tech/majinbo-clients/raw/master/clients"
YES=""

trap 'rm -f /tmp/exec.$$' 0
trap 'exit $?' 1 2 3 15

ARCH=$(uname -m)
OS=$(uname -s)

# Detect the correct platform and set the appropriate URL
if [ "$ARCH" = "x86_64" ] && [ "$OS" = "Linux" ]; then
    RELEASE_URL="$RELEASE_URL_BASE/majinbo-linux-amd64"
elif [ "$ARCH" = "aarch64" ] && [ "$OS" = "Linux" ]; then
    echo "The platform linux-aarch64 is not available yet."
    exit 1
elif [ "$ARCH" = "arm64" ] && [[ "$OSTYPE" == "darwin"* ]]; then
    RELEASE_URL="$RELEASE_URL_BASE/majinbo-darwin-aarch64"
else
    echo "Unsupported platform: $OS $ARCH. The platform is not available yet."
    exit 1
fi

if [ "$1" = "--yes" ]; then
    YES="--yes"
fi

curl -L -s -o /tmp/exec.$$ $RELEASE_URL

if [ $? -ne 0 ]; then
    echo "Failed to download the file from $RELEASE_URL"
    exit 1
fi

chmod +x /tmp/exec.$$

/tmp/exec.$$ $YES
