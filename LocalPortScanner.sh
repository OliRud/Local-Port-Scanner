#!/bin/bash

##sudo chmod +x scanner.sh
##sudo ./scanner.sh

COOLDOWN=5

# root access verification
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (sudo)."
  exit 1
fi

# nmap check
if ! command -v nmap &> /dev/null; then
  echo "nmap is not installed. Installing it now..."
  
  # Detect package manager and install nmap
  if command -v apt-get &> /dev/null; then
    apt-get update && apt-get install -y nmap
  elif command -v yum &> /dev/null; then
    yum install -y nmap
  elif command -v dnf &> /dev/null; then
    dnf install -y nmap
  elif command -v pacman &> /dev/null; then
    pacman -Syu --noconfirm nmap
  else
    echo "Error: Package manager not recognized. Please install nmap manually."
    exit 1
  fi
fi

echo "nmap is verified. Starting continuous console scanner..."
echo "Press [CTRL+C] to stop."
echo "--------------------------------------------------"

# mainloop
while true; do
  CURRENT_TIME=$(date "+%Y-%m-%d %H:%M:%S")
  echo "[$CURRENT_TIME] Scanning localhost for open ports..."

  SCAN_RESULTS=$(nmap -sS localhost | grep -E '/tcp|/udp' | grep 'open')
  
  if [ -z "$SCAN_RESULTS" ]; then
    echo "[$CURRENT_TIME] No open ports detected."
  else
    echo "[$CURRENT_TIME] DETECTED OPEN PORTS:"
    echo "$SCAN_RESULTS"
  fi
  
  echo "--------------------------------------------------"

  sleep "$COOLDOWN"
done