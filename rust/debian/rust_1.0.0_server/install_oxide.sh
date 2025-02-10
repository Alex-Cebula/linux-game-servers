#!/bin/sh
# POSIX-compliant shebang

set -e

TEMP_FILE_NAME="oxide"
TEMP_PATH="/tmp/rust_server"
OXIDE_URL="https://umod.org/games/rust/download/develop"
RUST_SERVER_PATH="/home/rust/server"

# Download oxide to temp directory
mkdir $TEMP_PATH
wget -P $TEMP_PATH -O $TEMP_FILE_NAME $OXIDE_URL

# Unzip oxide into rust server
unzip -o "${TEMP_PATH}${TEMP_FILE_NAME}" -d $RUST_SERVER_PATH
rm -r $TEMP_PATH