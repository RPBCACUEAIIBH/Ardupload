#! /bin/bash

# Finding roots
PWDir="$(pwd)"
cd $(cd "$(dirname "$0")"; pwd -P)
OwnDir="$(pwd)"
cd "$PWDir"

if [[ $(whoami) == "root" ]]
then
  AmIroot=yes
else
  AmIroot=no
fi

# Get arguments
ConfigFile="$OwnDir/avrdude.conf"

if [[ -z $(echo "$1" | grep ".hex") || -z $(echo "$2" | grep "/dev/") ]]
then
  echo "usage: UpdateArduino.sh [/path/file.hex] [port]"
  exit
fi
HexFile="$1"
Port="$2"

# Checking if avrdude is installed
if [[ -z $(dpkg -s avrdude | grep "Version") ]]
then
  if [[ $AmIroot == "yes" ]]
  then
    apt-get -y install avrdude
  else
    sudo apt-get -y install avrdude
  fi
fi

# Checking hexfile
if [[ ! -f $HexFile ]]
then
  echo "There's no such hexfile!"
  exit
fi

# Checking port
if [[ ! -e $Port ]]
then
  echo "Could not find the specified port!"
  exit
fi

# Upload hex file
eval $(echo "avrdude -C$ConfigFile -v -patmega328p -carduino -P$Port -b57600 -D -Uflash:w:$HexFile:i")
