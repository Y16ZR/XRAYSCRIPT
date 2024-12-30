#!/bin/bash
#wget https://github.com/${GitUser}/
fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "  \033[1;33mWAIT \033[1;37m- \033[1;33m["
while true; do
   for((i=0; i<3; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   tput cuu1
   tput dl1
   echo -ne "  \033[1;33mWAIT \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}

GitUser="EZ-Code00"

#IPVPS
MYIP=$(curl -sS ipv4.icanhazip.com)

#Colour
white='\e[0;37m'
green='\e[0;32m'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
yellow='\e[0;33m'
NC='\e[0m'

clear
echo -e "[\e[32;1mINFO\e[0m] LOADING MENU. . ."
fun_start () {
#TARIKH EXP
rm -f /usr/bin/e
valid=$( curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}' )
echo "$valid" > /usr/bin/e
}
fun_bar 'fun_start'
exp=$(cat /usr/bin/e)

# STATUS EXPIRED ACTIVE
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[4$below" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}ACTIVE${Font_color_suffix}"
Error="${Green_font_prefix}${Font_color_suffix}${Red_font_prefix}EXPIRED -Please renew first${Font_color_suffix}"
today=`date -d "0 days" +"%Y-%m-%d"`
if [[ $today < $exp ]]; then
sts="${Info}"
else
sts="${Error}"
fi

# CERTIFICATE STATUS
d1=$(date -d "$exp" +%s)
d2=$(date -d "$today" +%s)
certifacate=$(( (d1 - d2) / 86400 ))

#NAMA ISP
NAMAISP=$( curl -s ipinfo.io/org | cut -d " " -f 2-10  )

#Getting OS Information
source /etc/os-release
Versi_OS=$VERSION
Tipe=$NAME
COUNTRY=$( curl -s ipinfo.io/country )
CITY=$( curl -s ipinfo.io/city )

# Getting Domain Name
Domen="$(cat /usr/local/etc/xray/domain)"

#status xray
statusxray="$(systemctl show xray.service --no-page)"
status_textxray=$(echo "${statusxray}" | grep 'ActiveState=' | cut -f2 -d=)
ONXRAY="\e[0;32mON\e[0m"
OFFXRAY="\e[0;31mOFF\e[0m"
if [ "${status_textxray}" == "active" ]                           
then
xray=$ONXRAY
else
xray=$OFFXRAY
fi

#JUMLAH VMESS WS
JUMLAHVMESSWS=$(grep -c -E "^#vms " "/usr/local/etc/xray/config.json")

#JUMLAHVMESSWS
JUMLAHVLESSWS=$(grep -c -E "^#vls " "/usr/local/etc/xray/config.json")

#JUMLAH VLESS XTLS
JUMLAHVLESSXTLS=$(grep -c -E "^#vxtls " "/usr/local/etc/xray/config.json")

#JUMLAH TROJAN WS
JUMLAHTROJANWS=$(grep -c -E "^### " "/usr/local/etc/xray/akuntrws.conf")

#JUMLAH TROJAN GRPC TLS$NC
JUMLAHTROJANGRPC=$(grep -c -E "^### " "/usr/local/etc/xray/akunxtrgrpc.conf")

#VERSION XRAY INSTALLED ON SCRIPT
xray_version="$(xray version | head -n 1 | awk '{print $2}')"


#CHECK VERSION XRAY CORE LATEST VERSION
latest_version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"

#INSTALLATION XRAY CORE LATEST VERSION
xraycore_link="https://github.com/XTLS/Xray-core/releases/download/v$latest_version/xray-linux-64.zip"

latest="\e[0;32m[LATEST VERSION]\e[0m"
old="\e[0;31m[OLD VERSION]\e[0m"
if [ $xray_version = $latest_version ]; then
xversion=$latest
else
xversion=$old
fi



clear
echo ""
echo ""
echo -e   " \e[0;34m ════════════════════════════════════════════════════════════\e[m"
echo -e   " \e[0;34m ║\e[104m                \e[97m WELCOME TO PREMIUM SCRIPT \e[1m               \e[m\e[0;34m║"
echo -e   " \e[0;34m ╔══════════════════════════════════════════════════════════╗\e[m"
echo -e "  \e[0;34m║       ${green}CREATED BY ${green}EZ-Code${NC} (${blue}https://t.me/EzcodeShop${NC})"
echo -e "  \e[0;34m║"
echo -e "  \e[0;34m║  \e[0;94mISP           \e[0;34m=\e[0;94m $NAMAISP       "
echo -e "  \e[0;34m║  \e[0;94mOS            \e[0;34m=\e[0;94m $NAME $Versi_OS"
echo -e "  \e[0;34m║  \e[0;94mCITY          \e[0;34m=\e[0;94m $CITY ($COUNTRY)"
echo -e "  \e[0;34m║  \e[0;94mIP VPS        \e[0;34m=\e[0;94m $MYIP           "
echo -e "  \e[0;34m║  \e[0;94mDOMAIN        \e[0;34m=\e[0;94m $Domen          "
echo -e "  \e[0;34m║  \e[0;94mEXPIRY SCRIPT \e[0;34m=\e[0;97m $exp ${green} ($certifacate days)"
echo -e "  \e[0;34m║  \e[0;94mEXPIRY STATUS \e[0;34m=\e[0;94m $sts "
echo -e "  \e[0;34m╚══════════════════════════════════════════════════════════╝\e[m"
echo -e "  ${yellow} XRAY VERSION:${NC} ${xray_version} ${xversion}"
echo ""
echo -e "        \e[0;94mSSH : $ssh   \e[0;94mOVPN : $ovpn   \e[0;94mXRAY : $xray   \e[0;94mSS : $xray"
echo -e "       $green——————————$blue———————————————$cyan————————————$yellow—————————――$NC"
echo -e "  \e[0;34m┏━━━━━━━━━━━━━━━━[ \e[0;33mCONTROLL PANEL MENU\e[m \e[0;34m]━━━━━━━━━━━━━━━━━━━┓"
echo -e "  \e[0;34m┃                                                          ┃"
echo -e "      $green[${white}•1${green}] ${white}SSH/OPENVPN$NC          $green[${white}•5${green}] ${white}XRAY VMESS/VLESS WS$NC"
echo -e "      $green[${white}•2${green}] ${white}WIREGUARD$NC            $green[${white}•6${green}] ${white}XRAY VLESS TCP XTLS$NC"
echo -e "      $green[${white}•3${green}] ${white}SHADOWSOCKS$NC          $green[${white}•7${green}] ${white}XRAY TROJAN WEBSOCKET$NC"
echo -e "      $green[${white}•4${green}] ${white}SHADOWSOCK-R$NC         $green[${white}•8${green}] ${white}XRAY TROJAN GRPC TLS$NC"
echo -e "  \e[0;34m┃                                                          ┃"
echo -e "  \e[0;34m┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
echo -e "  ┏       ${yellow}SYSTEM MENU             \e[0;34m┃$NC       ${yellow}TOTAL USER ${NC}        \e[0;34m┓"
echo -e "  \e[0;34m┃$NC      $green—————————————            \e[0;34m┃      ${green}————————————$NC        \e[0;34m┃"
echo -e "  \e[0;34m┃$NC$green[${white}•9${green}] ${white}RESTART ALL SERVICE       \e[0;34m┃$NC    SSH & OVPN   $green   =$NC $yellow$JUMLAHSSH"
echo -e "  \e[0;34m┃$NC$green[${white}10${green}] ${white}SERVER AUTO-REBOOT        \e[0;34m┃$NC                          \e[0;34m┃$NC"
echo -e "  \e[0;34m┃$NC$green[${white}11${green}] ${white}DOMAIN CLOUDFLARE         \e[0;34m┃$NC    VMESS/VLESS WS  $green=$NC $yellow$JUMLAHVMESSWS "
echo -e "  \e[0;34m┃$NC$green[${white}12${green}] ${white}BACKUP/RESTORE SERVER     \e[0;34m┃$NC                          \e[0;34m┃$NC"
echo -e "  \e[0;34m┃$NC$green[${white}13${green}] ${white}ADD/CHANGE DOMAIN SERVER  \e[0;34m┃$NC    VlESS XTLS   $green   =$NC $yellow$JUMLAHVLESSXTLS "
echo -e "  \e[0;34m┃$NC$green[${white}14${green}] ${white}ADD/CHANGE NS(SLOW DNS)   \e[0;34m┃$NC                          \e[0;34m┃$NC"
echo -e "  \e[0;34m┃$NC$green[${white}15${green}] ${white}RENEW CERTIFICATE XRAY    \e[0;34m┃$NC    TROJAN WS   $green    =$NC $yellow$JUMLAHTROJANWS"
echo -e "  \e[0;34m┃$NC$green[${white}16${green}] ${white}SHOW ALL PORT VPN         \e[0;34m┃$NC                          \e[0;34m┃$NC"
echo -e "  \e[0;34m┃$NC$green[${white}17${green}] ${white}CHANGE PORT VPN           \e[0;34m┃$NC    TROJAN GRPC   $green  =$NC $yellow$JUMLAHTROJANGRPC "
echo -e "  \e[0;34m┃$NC$green[${white}18${green}] ${white}SHOW RUNNING SCRIPT       \e[0;34m┃$NC                          \e[0;34m┃$NC"
echo -e "  \e[0;34m┃$NC$green[${white}19${green}] ${white}CLEAR-LOG & CACHE         \e[0;34m┃$NC    WIREGUARD   $green    =$NC $yellow$JUMLAHWG "
echo -e "  \e[0;34m┃$NC$green[${white}20${green}] ${white}SHOW SERVER BANDWITH      \e[0;34m┃$NC                          \e[0;34m┃$NC"
echo -e "  \e[0;34m┃$NC$green[${white}21${green}] ${white}CHANGE PASSWORD VPS       \e[0;34m┃$NC    SHADOWSOCKS   $green  =$NC $yellow$JUMLAHSS"
echo -e "  \e[0;34m┃$NC$green[${white}22${green}] ${white}SHOW SPEEDTEST SERVER     \e[0;34m┃$NC                          \e[0;34m┃$NC"
echo -e "  \e[0;34m┃$NC$green[${white}23${green}] ${white}UPDATE XRAY CORE          \e[0;34m┃$NC    SHADOWSOCKS-R  $green =$NC $yellow$JUMLAHSSR"
echo -e "  \e[0;34m┃$NC$green[${white}24${green}] ${white}UPDATE PREMIUM SCRIPT     \e[0;34m┃$NC                          \e[0;34m┃$NC"
echo -e "  \e[0;34m┃$NC$green[${white}25${green}] ${white}REBOOT SERVER             \e[0;34m┃$NC                          \e[0;34m┃$NC"
echo -e "  \e[0;34m╔══════════════════════════════════════════════════════════╗\e[m"
echo -e "   $green[${white}•0${green}] ${white}Exit from the menu ${blue}[${red}Ctrl + C${NC}${blue}]$NC"
echo -e "  \e[0;34m╚══════════════════════════════════════════════════════════╝\e[m"
read -p "  $(echo -e ${yellow}         Enter Your Options  ${green}[${NC}${white}1-25 or x${green}]${NC} :)  "  main
echo -e ""
case $main in
1)
menu-ssh
;;
2)
menu-wg
;;
3)
menu-ss
;;
4)
menu-ssr
;;
5)
x-vmess
;;
6)
x-vless
;;
7)
x-tr
;;
8)
x-trojan
;;
9)
restart
;;
10)
autoreboot
;;
11)
menu-domain
;;
12)
menu-br
;;
13)
add-host
;;
14)
add-ns
;;
15)
cert
;;
16)
info
;;
17)
change-port
;;
18)
check-sc
;;
19)
clear-log
;;
20)
vnstat
;;
21)
passwd
;;
22)
speedtest
;;
23)
xray-update
;;
24)
script-update
;;
25)
reboot
;;
X)
exit
;;
x)
exit
;;
0)
exit
;;
*)
echo -e "${red}Please enter an correct number ${NC}"
sleep 1
menu
;;
esac