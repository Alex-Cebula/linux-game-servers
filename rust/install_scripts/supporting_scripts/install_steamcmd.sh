#!/bin/sh

set -e

apt update
apt upgrade -y

# Install software-properties-common package
apt install software-properties-common

# Add 32bit x86 architecture
dpkg --add-architecture i386

# Add non-free repository
apt-add-repository non-free

# Install steamcmd
apt install steamcmd

# Test steamcmd
bash /usr/games/steamcmd +quit