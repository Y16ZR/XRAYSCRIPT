#!/bin/bash
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
   for((i=0; i<10; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.10s
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

version=$(cat /home/ver)
new_version=$( curl https://raw.githubusercontent.com/EZ-Code00/version-scxray/main/version.conf | grep $version )
if [ $version = $new_version ]; then
clear
echo ""
echo -e "\e[1;31mChecking New Version, Please Wait...!\e[m"
sleep 3
clear
echo -e "\e[1;31mUpdate Not Available\e[m"
echo ""
clear
sleep 1
echo -e "\e[1;36mYou Have The Latest Version\e[m"
echo -e "\e[1;31mThankyou.\e[0m"
sleep 3
menu
else
clear
echo -e "\e[1;31mUpdate Available Now..\e[m"
echo -e ""
sleep 2
echo -e "\e[1;36mStart Update For New Version, Please Wait..\e[m"
sleep 2
clear
echo -e "\e[0;32mGetting New Version Script By V-Code...\e[0m"
sleep 1
echo ""
# RUN UPDATE
echo ""
clear
echo -e "\e[0;32mPlease Wait...!\e[0m"
sleep 6
clear
echo ""
clear
echo -e "\e[0;32mNew Version Downloading started!\e[0m"
sleep 2
fun_start () {
cd /usr/bin
wget -O x-trojan "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/MENU/x-trojan.sh"
wget -O x-tr "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/MENU/x-tr.sh"
wget -O x-vmess "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/MENU/x-vmess.sh"
wget -O x-vless "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/MENU/x-vless.sh"
wget -O xray-update "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/SYSTEM/xray-update.sh"
wget -O trial-trojan "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/TRIAL-USER/trial-trojan.sh"
wget -O trial-tr "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/TRIAL-USER/trial-tr.sh"
wget -O trial-vmess "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/TRIAL-USER/trial-vmess.sh"
wget -O trial-vless "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/TRIAL-USER/trial-vless.sh"
wget -O add-trojan "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/ADD-USER/add-trojan.sh"
wget -O add-tr "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/ADD-USER/add-tr.sh"
wget -O add-vmess "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/ADD-USER/add-vmess.sh"
wget -O add-vless "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/ADD-USER/add-vless.sh"
wget -O menu "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/menu.sh"
wget -O menu-br "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/MENU/menu-br.sh"
wget -O add-ssh "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/ADD-USER/add-ssh.sh"
wget -O trial "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/TRIAL-USER/trial.sh"
wget -O script-update "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/script-updatessh.sh"
wget -O menu-ssh "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/MENU/menu-ssh.sh"
wget -O check-sc "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/SYSTEM/running.sh"
wget -O menu-wg "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/MENU/menu-wg.sh"
wget -O add-wg "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/ADD-USER/add-wg.sh"
wget -O /usr/bin/menu-ssr https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/MENU/menu-ssr.sh && chmod +x /usr/bin/menu-ssr
wget -O /usr/bin/add-ssr https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/ADD-USER/add-ssr.sh && chmod +x /usr/bin/add-ssr
wget -O add-ss "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/ADD-USER/add-ss.sh"
wget -O menu-ss "https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTFALLBACK/main/MENU/menu-ss.sh"
chmod +x x-trojan
chmod +x x-tr
chmod +x x-vmess
chmod +x x-vless
chmod +x xray-update
chmod +x trial-trojan
chmod +x trial-tr
chmod +x trial-vless
chmod +x trial-vmess
chmod +x add-trojan
chmod +x add-tr
chmod +x add-vmess
chmod +x add-vless
chmod +x add-trojan
chmod +x add-tr
chmod +x menu
chmod +x menu-br
chmod +x add-ssh
chmod +x trial
chmod +x script-update
chmod +x menu-ssh
chmod +x running
chmod +x menu-wg
chmod +x add-wg
chmod +x add-ss
chmod +x menu-ss
}
fun_bar 'fun_start'
echo -e ""
echo -e "\e[0;32mDownloaded successfully!\e[0m"
echo ""
ver=$( curl https://raw.githubusercontent.com/EZ-Code00/version-scxray/main/version.conf )
sleep 1
echo -e "\e[0;32mPatching New Update, Please Wait...\e[0m"
echo ""
sleep 2
echo -e "\e[0;32mPatching... OK!\e[0m"
sleep 1
echo ""
echo -e "\e[0;32mSucces Update Script For New Version\e[0m"
cd
echo "$ver" > /home/ver
echo ""
echo -e " \e[1;31mReboot 5 Sec\e[0m"
sleep 5
rm -f update.sh
rm -rf update
reboot
fi
