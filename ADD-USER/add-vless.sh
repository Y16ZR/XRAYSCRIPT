#!/bin/bash
#wget https://github.com/${GitUser}/
GitUser="EZ-Code00"

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
   for((i=0; i<1; i++)); do
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

#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)

# Valid Script
VALIDITY () {
#TARIKH EXP
today=`date -d "0 days" +"%Y-%m-%d"`
exp=$(cat /usr/bin/e)	
    if [[ $today < $exp ]]; then
    echo -e ""
    else
    echo -e "\e[31mYOUR SCRIPT HAS EXPIRED!\e[0m"
    echo -e "\e[31mPlease renew your ipvps first\e[0m"
    exit 0
fi
}

#CHECK IZIN IPVPS
clear
echo -e "[\e[32;1mINFO\e[0m] LOADING . . ."
fun_start () {
rm -f /usr/bin/e
valid=$( curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}' )
echo "$valid" > /usr/bin/e
IZIN=$(curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | awk '{print $5}' | grep $MYIP)
echo "$IZIN" > /usr/bin/ipvps
}
fun_bar 'fun_start'
IZIN2=$(cat /usr/bin/ipvps)
if [ $MYIP = $IZIN2 ]; then
VALIDITY
else
clear
echo ""
echo ""
echo -e "\e[31mPermission Denied!\e[0m";
echo -e "\e[31mPlease buy script first\e[0m"
exit 0
fi

# PROVIDED
creditt=$(cat /root/provided)
# TEXT ON BOX COLOUR
box=$(cat /etc/box)
# LINE COLOUR
line=$(cat /etc/line)
# BACKGROUND TEXT COLOUR
back_text=$(cat /etc/back)
MYIP=$(curl -sS ipv4.icanhazip.com)
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /usr/local/etc/xray/domain)
else
domain=$IP
fi
clear
echo ""
echo ""
xtls="$(cat ~/log-install.txt | grep -w "Vless Tcp Xtls" | cut -d: -f2|sed 's/ //g')"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
echo -e   "  \e[$back_text          \e[0;30m[\e[$box CREATE USER XRAY VLESS TCP XTLS\e[0;30m ]\e[0m\e[$back_text          \e[m"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "   Username: " -e user
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "   Bug Address (Example: www.google.com) : " address
read -p "   Bug SNI/Host (Example : m.facebook.com) : " sni
read -p "   Expired (days) : " masaaktif
bug_addr=${address}.
bug_addr2=$address
if [[ $address == "" ]]; then
sts=$bug_addr2
else
sts=$bug_addr
fi
#BUG SNI
bug_sni=bug.com
bug_sni2=${sni}
if [[ $sni == "" ]]; then
stn=${bug_sni}
else
stn=$bug_sni2
fi
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
harini=`date -d "0 days" +"%Y-%m-%d"`
sed -i '/#xray-vless-xtls$/a\#vxtls '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","flow": "'""xtls-rprx-vision""'","level": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json
vlesslink1="vless://${uuid}@${sts}${domain}:$xtls?security=tls&encryption=none&headerType=none&fp=qq&type=tcp&flow=xtls-rprx-vision&sni=${stn}#${user}"
systemctl restart xray
clear
echo -e ""
echo -e "\e[$line════════[XRAY VLESS XTLS]════════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "Ip/Host        : ${MYIP}"
echo -e "Port Xtls      : $xtls"
echo -e "User ID        : ${uuid}"
echo -e "Encryption     : None"
echo -e "Network        : TCP"
echo -e "Flow           : Vision Tls"
echo -e "AllowInsecure  : True"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Xtls Vision  : ${vlesslink1}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created  : $harini"
echo -e "Expired  : $exp"
echo -e "Script By $creditt"