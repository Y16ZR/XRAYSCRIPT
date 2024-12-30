#!/bin/bash
MYIP=$(curl -sS ipv4.icanhazip.com)

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
   for((i=0; i<5; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.2s
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

VALIDITY () {
#TARIKH EXP
today=`date -d "0 days" +"%Y-%m-%d"`
exp=$(cat /usr/bin/e)	
    if [[ $today < $exp ]]; then
	echo -e "[ \e[32;1mINFO\e[0m ] CHECK PERMISSION FOR VALIDITY SCRIPT . . ."
	sleep 2
    echo ""
    echo ""
    echo -e "\e[32mYOUR SCRIPT ACTIVE..\e[0m"
	sleep 1
    else
	clear
	echo ""
	echo ""
    echo -e "\e[31mYOUR SCRIPT HAS EXPIRED!\e[0m";
    echo -e "\e[31mPlease renew your ipvps first\e[0m"
    echo -e "\e[31mContact Admin for buy/register your ipvps\e[0m"
    echo -e "\e[31mTelegram @EzcodeShop\e[0m"
	sleep 5
    exit 5
fi
}

#CHECK IZIN IPVPS
clear
echo -e "[ \e[32;1mINFO\e[0m ] CHECK PERMISSION FOR INSTALLATION SCRIPT. . ."
sleep 2
fun_start () {
valid=$( curl https://raw.githubusercontent.com/EZ-Code00/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}' )
echo "$valid" > /usr/bin/e
IZIN=$(curl https://raw.githubusercontent.com/EZ-Code00/allow/main/ipvps.conf | awk '{print $5}' | grep $MYIP)
echo "$IZIN" > /usr/bin/ipvps
}
fun_bar 'fun_start'
IZIN2=$(cat /usr/bin/ipvps)
if [ $MYIP = $IZIN2 ]; then
echo -e "\e[32mPERMISSION ACCEPTED...\e[0m"
sleep 1
VALIDITY
else
clear
echo ""
echo ""
echo -e "\e[31mPERMISSION DANIED!\e[0m";
echo -e "\e[31mContact Admin for buy/register your ipvps\e[0m"
echo -e "\e[31mTelegram @EzcodeShop\e[0m"
sleep 5
exit 5
fi

#COLOUR
white='\e[0;37m'
green='${blue}'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
NC='\e[0m'

mkdir /var/lib/premium-script;
default_email=$( curl https://raw.githubusercontent.com/EZ-Code00/email/main/default.conf )
clear
echo ""
echo -e "${blue}════════════════════════════════════════════════════════════${NC}"
tput setaf 7 ; tput setab 6 ; tput bold ; printf '%44s%s%-16s\n' "WELCOME TO PREMIUM SCRIPT" ; tput sgr0
echo -e "${blue}════════════════════════════════════════════════════════════${NC}"
echo -e ""
echo -e "         This script will do the installation"
echo -e "                    By EZ-Code"
echo -e ""
echo -e "             ${cyan}Script made by @EzcodeShop ${red}❤️${NC}"
echo -e "${blue}════════════════════════════════════════════════════════════${NC}"
echo ""
#Nama penyedia script
echo -e "${blue}════════════════════════════════════════════════════════════\e[0m"
echo ""
echo -e "   ${blue}Please enter the name of Provider for Script."
read -p "   Name : " nm
echo $nm > /home/provided
echo ""
#Email domain
echo -e "${blue}════════════════════════════════════════════════════════════\e[0m"
echo -e ""
echo -e "   ${blue}Please enter your email Domain/Cloudflare."
echo -e "   \e[1;31m(Press ENTER for default email)\e[0m"
read -p "   Email : " email
default=${default_email}
new_email=$email
if [[ $email == "" ]]; then
sts=$default_email
else
sts=$new_email
fi
# email
mkdir -p /usr/local/etc/xray/
touch /usr/local/etc/xray/email
echo $sts > /usr/local/etc/xray/email
echo ""
echo -e "${blue}════════════════════════════════════════════════════════════\e[0m"
echo ""
echo -e "   .----------------------------------."
echo -e "   |${blue}Please select a domain type below \e[0m|"
echo -e "   '----------------------------------'"
echo -e "     ${blue}1)\e[0m Enter your Subdomain"
echo -e "     ${blue}2)\e[0m Use a random Subdomain"
echo -e "   ------------------------------------"
read -p "   Please select numbers 1-2 or Any Button(Random) : " host
echo ""
if [[ $host == "1" ]]; then
echo -e "   ${blue}Please enter your subdomain "
read -p "   Subdomain: " host1
echo "IP=" >> /var/lib/premium-script/ipvps.conf
touch /usr/local/etc/xray/domain
echo $host1 > /usr/local/etc/xray/domain
echo ""
elif [[ $host == "2" ]]; then
#install cf
echo -e "Random Domain is not available now"
echo ""
#wget https://raw.githubusercontent.com/EZ-Code00/Doxou/main/install/cf.sh && chmod +x cf.sh && ./cf.sh
#rm -f /root/cf.sh
clear
else
#install cf
echo -e "Random Domain is not available now"
echo ""
#wget https://raw.githubusercontent.com/EZ-Code00/Doxou/main/install/cf.sh && chmod +x cf.sh && ./cf.sh
#rm -f /root/cf.sh
clear
fi
echo ""
echo -e "${blue}READY FOR INSTALLATION SCRIPT...\e[0m"
sleep 1
echo ""
echo -e "DOWNLOADING REQUIRED TOOLS..."
echo ""
#INSTALL TOOLS
wget https://raw.githubusercontent.com/Y16ZR/XRAYSCRIPT/main/INSTALL/tools.sh && chmod +x tools.sh && screen -S tools ./tools.sh
clear
echo ""
echo -e "DOWNLOADING XRAY..."
echo ""
#INSTALL XRAY
wget https://raw.githubusercontent.com/Y16ZR/XRAYSCRIPT/main/INSTALL/ins-xray.sh && chmod +x ins-xray.sh && screen -S ins-xray ./ins-xray.sh
clear
echo ""
echo -e "DOWLOADING SET-BR..."
echo ""
#INSTALL SET-BR
wget https://raw.githubusercontent.com/Y16ZR/XRAYSCRIPT/main/INSTALL/set-br.sh && chmod +x set-br.sh && ./set-br.sh
echo ""
echo ""
echo "1;37m" > /etc/box
echo "1;34m" > /etc/line
echo "46m" > /etc/back

#finish
rm -f /root/tools.sh
rm -f /root/ins-xray.sh
rm -f /root/set-br.sh

cd
#VERSION
ver=$( curl https://raw.githubusercontent.com/EZ-Code00/version-scxray/main/version.conf )
history -c
echo "$ver" > /home/ver
clear
echo " "
wget -O /root/log-install.txt "https://raw.githubusercontent.com/Y16ZR/XRAYSCRIPT/main/vps.conf"
echo "Installation has been completed!!"
echo ""
cat /root/log-install.txt 
sleep 2
clear
echo -e "${blue}════════════════════════════════════════════════════\033[0m"
tput setaf 7 ; tput setab 6 ; tput bold ; printf '%45s%s%-7s\n' "SUCCESSFULLY INSTALLED PREMIUM SCRIPT" ; tput sgr0
echo -e "${blue}════════════════════════════════════════════════════\033[0m"
echo ""
echo -e "Script created by Ez-Code"
echo ""
echo -e "For private concerns/report/donations: https://t.me/EzcodeShop"
echo ""
echo ""
echo -e "[Note] DO NOT RESELL THIS SCRIPT"
echo -e "This script is under project/sell of https://shopee.com.my/product/567861532/9896120812?smtt=0.567881117-1659683556.10 "
echo -e "THANKS FOR BUY & SUPPORT OUR BUSINESS"
echo ""
echo -e "             \033[1;33mINSTALLATION COMPLETED!\033[0m          "
echo ""
echo ""
echo ""
echo -e "${red}Auto reboot in 10 seconds...${NC}"
echo ""
rm -r choose.sh
rm -r setup.sh
sleep 10
reboot
