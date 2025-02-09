#!/bin/sh
# POSIX-compliant shebang

set -e

# Ensure repositories up to date
apt update
apt updage -y

# Install software-properties-common package
apt install software-properties-common

# Add non-free repository
apt-add repository non-free

# Install steamcmd
apt install steamcmd

# Add steam user
adduser -m steam

# Test steamcmd
su -C 'steamcmd +quit' steam