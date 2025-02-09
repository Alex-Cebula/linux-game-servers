#!/bin/sh
# POSIX-compliant shebang

set -e

# shellcheck disable=SC1091
. ./config_helper.sh

echo "Config prompts"
echo "--------------"

# Prompt server name
#####################
name=""
nameValid=false
prompt_name(){
    read -r "What would you like your server name to be?" name
}

while [ "$nameValid" = false ]; do
    prompt_name

    if [ ${#name} -gt 0 ] && { [ ${#name} -lt 50 ] || [ ${#name} -eq 50 ]; }; then
        nameValid=true
    fi
done
name "$name"

# Prompt server description
###########################
description=""
descriptionValid=false
prompt_description(){
    read -r "What would you like your server description to be?" description
}

while [ $descriptionValid = false ]; do
    prompt_description
 
    if [ ${#description} -gt 0 ] && { [ ${#description} -lt 250 ] || [ ${#description} -eq 250 ]; }; then
        descriptionValid=true
    fi
done
description "$description"

# Prompt server map size
########################
size=""
sizeValid=false
prompt_size(){
    read -r "What would you like your server map size to be?" size
}

while [ $sizeValid = false ]; do
    prompt_size

    if { [ "$size" -lt 4500 ] || [ "$size" -eq 4500 ]; } && { [ "$size" -gt 1000 ] || [ "$size" -eq 1000 ]; }; then
        sizeValid=true
    fi
done
size "$size"

# Prompt server seed
####################
seed=""
seedValid=false
prompt_seed(){
    read -r "What would you like your server map seed to be?" seed
}

while [ $seedValid = false ]; do
    prompt_seed

    if [ ${#seed} -gt 0 ] && { [ ${#seed} -lt 250 ] || [ ${#seed} -eq 250 ]; }; then
        seedValid=true
    fi
done
seed "$seed"

# Prompt server max players
###########################
max_players=""
max_playersValid=false
prompt_max_players(){
    read -r "What would you like your server max players to be?" max_players
}

while [ $max_playersValid = false ]; do
    prompt_max_players

    if [ "$max_players" -gt 0 ]; then
        max_playersValid=true
    fi
done
max_players "$max_players"

# Prompt server port
####################
port=""
portValid=false
prompt_port(){
    read -r "What would you like your server port to be?" port
}

while [ $portValid = false ]; do
    prompt_port

    if [ ${#port} -eq 4 ]; then
        portValid=true
    fi
done
port "$port"

# Prompt enable rcon
####################
enable_rcon="N"
enable_rconValid=false
prompt_enable_rcon(){
    read -r "Would you like rcon enabled (Y/N)?" enable_rcon
}

while [ $enable_rconValid = false ]; do
    prompt_enable_rcon

    if [ "$(expr "$enable_rcon" : '^[Nn]$')" -gt 0 ] || [ "$(expr "$enable_rcon" : '^[Yy]$')" -gt 0 ]; then
        enable_rconValid=true
    fi
done

enable_rcon_value=0
if [ "$(expr "$enable_rcon" : '^[Yy]$')" -gt 0 ]; then
    enable_rcon_value=1
fi
enable_rcon "$enable_rcon_value"

if [ $enable_rcon_value = 1 ]; then 

    # Prompt server rcon port
    #########################
    rcon_port=""
    rcon_portValid=false
    prompt_rcon_port(){
        read -r "What would you like your server rcon port to be?" rcon_port
    }

    while [ $rcon_portValid = false ]; do
        prompt_rcon_port

        if [ ${#rcon_port} -eq 4 ]; then 
            rcon_portValid=true
        fi
    done
    rcon_port "$rcon_port"

    # Prompt server rcon password
    #############################
    rcon_password=""
    rcon_passwordValid=false
    prompt_rcon_password(){
        read -r "What would you like your server rcon password to be?" rcon_password
    }

    while [ $rcon_passwordValid = false ]; do
        prompt_rcon_password

        if [ ${#rcon_password} -gt 0 ]; then
            rcon_passwordValid=true
        fi
    done
    rcon_password "$rcon_password"
fi

# Prompt enable oxide
enable_oxide=""
enable_oxideValid=""
prompt_enable_oxide(){
    read -r "Would you like oxide enabled (Y/N)?" enable_oxide
}

while [ "$enable_oxideValid" = false ]; do
    prompt_enable_oxide

    if [ "$(expr "$enable_oxide" : '^[Nn]$')" -gt 0 ] || [ "$(expr "$enable_oxide" : '^[Yy]$')" -gt 0 ]; then
        enable_oxideValid=true
    fi
done

enable_oxide_value=0
if [ "$(expr "$enable_oxide" : '^[Yy]$')" -gt 0 ]; then
    enable_oxide_value=1
fi
enable_oxide "$enable_oxide_value"


