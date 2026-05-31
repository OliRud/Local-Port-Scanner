## Local port scanner for automated detection
A short script originally developed for my homelab, it installs nmap onto your Linux device and runs a scan for open ports on your system, then it logs the ports and even outputs the open ports in console.

The scan cooldown can be adjusted with the COOLDOWN variable
```
sudo chmod +x LocalPortScanner.sh
sudo ./LocalPortScanner.sh
```
