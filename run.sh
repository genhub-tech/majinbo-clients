#!/bin/sh

RELEASE_URL_BASE="https://github.com/genhub-tech/majinbo-clients/releases/download"
VERSION="latest"
YES=""

trap 'rm -f "/tmp/exec.$$"' 0
trap 'exit $?' 1 2 3 15

ARCH=$(uname -m)
OS=$(uname -s)

if [ "$ARCH" = "x86_64" ] && [ "$OS" = "Linux" ]; then
    RELEASE_URL="$RELEASE_URL_BASE/$VERSION/majinbo-linux-amd64"
elif [ "$ARCH" = "aarch64" ] && [ "$OS" = "Linux" ]; then
    RELEASE_URL="$RELEASE_URL_BASE/$VERSION/majinbo-linux-aarch64"
elif [ "$ARCH" = "aarch64" ] && [ "$OS" = "Darwin" ]; then
    RELEASE_URL="$RELEASE_URL_BASE/$VERSION/majinbo-darwin-aarch64"
else
    echo "Unsupported platform: $OS $ARCH"
    exit 1
fi

if [ "$1" = "--yes" ]; then
    YES="--yes"
fi

curl -L -s -o /tmp/exec.$$ $RELEASE_URL

chmod +x /tmp/exec.$$

/tmp/exec.$$ $YES
