#!/bin/bash
#   Goal:
#   Read openvpn.log for IP's on lines containing hack attempts
#	Then add to IPTABLES deny
#
#   README:
#
#	!! Requires root/su permissions !!
#   Set FILE_PATH to your openvpn.log
#
#   from command line, run:
#   sudo sed -i 's/\r//' bash_vpn_ipban_full.sh
#   to sanitize as unix carriage returns
#
#   sudo chmod +x bash_vpn_ipban_full.sh
#   to enable ability to execute
#
#

FILE_PATH="/etc/openvpn/openvpn.log"
IPS2BAN=$(grep "WARNING: Bad encapsulated packet length from peer" $FILE_PATH | sed -nE 's/.*([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}):[0-9]{1,5}.*/\1/p'|sort|uniq)

while read -r ip; do

#Skip empty lines and lines starting with '#'
[[ -z "${ip}" || "${ip}" =~ ^# ]] && continue

#Add the IP to the INPUT chain deny list
iptables -A INPUT -s "${ip}" -j DROP

#Add the IP to the FORWARD chain deny list (if necessary)
iptables -A FORWARD -s "${ip}" -j DROP

echo "Added ${ip} to iptables deny list"
# clear log, comment out if not required
sudo truncate -s 0 /etc/openvpn/openvpn.log
#
done <<< "${IPS2BAN}"

#Save iptables rules, create file if doesn't exist?
#touch /etc/iptables/rules.v4.automated.txt
#iptables-save > /etc/iptables/rules.v4.automated.txt

echo "All IPs added to iptables deny list successfully."
