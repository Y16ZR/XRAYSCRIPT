#!/bin/bash
#Colour
white='\e[0;37m'
green='\e[0;32m'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
yellow='\e[0;33m'
NC='\e[0m'
clear
echo -e ""
echo -e "  ${blue}=•= CHANGE PORT VPN =•=${NC}"
echo -e ""
echo -e "  $blue[${white}1${blue}] ${white}Change Port Stunnel$NC"
echo -e "  $blue[${white}2${blue}] ${white}Change Port OpenVPN$NC"
echo -e "  $blue[${white}3${blue}] ${white}Change Port OHP SSH$NC"
echo -e "  $blue[${white}4${blue}] ${white}Change Port Wireguard$NC"
echo -e "  $blue[${white}5${blue}] ${white}Change Port Xray Core$NC"
echo -e "  $blue[${white}6${blue}] ${white}Change Port Squid Proxy$NC"
echo -e "  $blue[${white}7${blue}] ${white}Change Port Websocket SSH$NC"
echo -e "  $blue[${white}x${blue}] ${red}Exit/Cancel$NC"
echo -e ""
read -p "  $(echo -e     ${white}Select from options  ${blue}[${NC}1-8 or x${blue}]${NC} :)  "  pdomain
echo -e ""
case $pdomain in
1)
port-ssl
;;
2)
port-ovpn
;;
3)
port-ohp
;;
4)
port-wg
;;
5)
port-xray
;;
6)
port-squid
;;
7)
port-websocket
;;
X)
exit
;;
x)
exit
;;
*)
echo "Please enter an correct number"
sleep 1
change-port
;;
esac
