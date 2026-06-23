#!/bin/bash
set -e

echo "==================================================="
echo "Building Time-Tracker Linux Binaries via Docker"
echo "==================================================="

# Ensure Docker is running
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed or not running."
    exit 1
fi

# Run electron-builder inside the official builder container
echo "Running electron-builder via Docker..."
docker run --rm -ti \
  -v "$(pwd):/project" \
  -v "$(pwd)/.npm-cache:/root/.npm" \
  electronuserland/builder:20 \
  sh -c "npm ci && npm run build"

echo ""
echo "==================================================="
echo "Build Successful!"
echo "Linux packages (.deb and .AppImage) are in:"
echo "$(pwd)/dist"
echo "==================================================="