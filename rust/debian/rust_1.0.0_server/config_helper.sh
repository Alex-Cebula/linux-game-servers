#!/bin/sh
# POSIX-compliant shebang

set -e

# Paths
CONFIG_PATH="../config.ini"

#Sections
SERVER="server"

# Variables
PORT="port"
SEED="seed"
SIZE="size"
MAX_PLAYERS="maxPlayers"
NAME="name"
DESCRIPTION="description"
RCON_PORT="rconPort"
RCON_PASSWORD="rconPassword"
ENABLE_RCON="enableRcon"
ENABLE_OXIDE="enableOxide"

__read_variable(){
    # shellcheck disable=SC2005
    echo "$(sed -n "/\[$1\]/,/\[/{/$2=/p}" $CONFIG_PATH | cut -d'=' -f2)"
}

__write_variable(){
    sed -i "/\[$1\]/,/\[/{/$2=/s/=.*/=$3/}" $CONFIG_PATH
}

__read_or_write_variable(){
    _write_variable=$($# -eq 3)
    if [ "$_write_variable" = true ]; then
        __write_variable "$1" "$2" "$3"
    else
        # shellcheck disable=SC2005
        echo "$(__read_variable "$1" "$2")"
    fi
}

port(){
    # shellcheck disable=SC2005
    echo "$(__read_or_write_variable $SERVER $PORT "$@")"
}

seed(){
     # shellcheck disable=SC2005
    echo "$(__read_or_write_variable $SERVER $SEED "$@")"
}   

size(){
     # shellcheck disable=SC2005
    echo "$(__read_or_write_variable $SERVER $SIZE "$@")"
}

max_players(){
     # shellcheck disable=SC2005
    echo "$(__read_or_write_variable $SERVER $MAX_PLAYERS "$@")"
}

name(){
     # shellcheck disable=SC2005
    echo "$(__read_or_write_variable $SERVER $NAME "$@")"
}

description(){
     # shellcheck disable=SC2005
    echo "$(__read_or_write_variable $SERVER $DESCRIPTION "$@")"
}

rcon_port(){
     # shellcheck disable=SC2005
    echo "$(__read_or_write_variable $SERVER $RCON_PORT "$@")"
}

rcon_password(){
     # shellcheck disable=SC2005
    echo "$(__read_or_write_variable $SERVER $RCON_PASSWORD "$@")"
}

enable_rcon(){
     # shellcheck disable=SC2005
    echo "$(__read_or_write_variable $SERVER $ENABLE_RCON "$@")"
}   

enable_oxide(){
    # shellcheck disable=SC2005
    echo "$(__read_or_write_variable $SERVER $ENABLE_OXIDE "$@")"
}

