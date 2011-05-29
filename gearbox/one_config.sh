#!/bin/bash

function GetOneConfig (){
  eval "local $2"
  scp -o PasswordAuthentication=no -o ConnectTimeout=6 -P $PORT $HOST:config.sh ./server_info/config_$1.sh &> /dev/null
  if [ $? -ne 0 ]; then
    echo $1_isup=0 > ./server_info/config_$1.sh
    echo isup=0 >> ./server_info/config_$1.sh
  else
    eval "local tmpvals='`ssh -o PasswordAuthentication=no -o ConnectTimeout=6 -p $PORT $HOST "./data_collect.sh 2> /dev/null"`'"
    echo "$1_isup=1" > ./server_info/config_$1.sh
    echo "isup=1" >> ./server_info/config_$1.sh
    echo "$1_status=\"$tmpvals\"" >> ./server_info/config_$1.sh
  fi
}

GetOneConfig $1 "$2"