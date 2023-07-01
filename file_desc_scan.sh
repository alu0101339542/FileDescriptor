#!/bin/bash
declare -a ports=($(seq 1 65535)) # Declare as an array

function CtrlC() {
  echo -e "\n\nExit\n"
  exit 1
}

function PortCheck() {
  host=$1
  port=$2
  (exec 3<>"/dev/tcp/$host/$port") 2>/dev/null
  if [ $? -eq 0 ]; then
    echo -e "Port $port is open\n"
  fi
  # Closing file descriptors
  exec 3<&-
  exec 3>&-
}

# Ctrl C
trap CtrlC SIGINT

if [ $1 ]; then
  for port in "${ports[@]}"; do
    PortCheck "$1" "$port" & # Using threads
  done
else
  echo -e "\n  Usage: $0 <ip-addr> \n"
fi

wait # For threads

