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

#Colour
white='\e[0;37m'
green='${blue}'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
NC='\e[0m'
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
tls="$(cat ~/log-install.txt | grep -w "Vmess Ws Tls" | cut -d: -f2|sed 's/ //g')"
tls2="$(cat ~/log-install.txt | grep -w "Vless Ws Tls" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess Ws None Tls" | cut -d: -f2|sed 's/ //g')"
none2="$(cat ~/log-install.txt | grep -w "Vless Ws None Tls" | cut -d: -f2|sed 's/ //g')"

echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
echo -e   "  \e[$back_text         \e[0;30m[\e[$box CREATE USER XRAY VMESS & VLESS WS \e[0;30m ]\e[0m\e[$back_text        \e[m"
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
patchtls=/xray-vmess
patchnontls=/xray-vmess
patchvtls=xray-vless
uuid=$(cat /proc/sys/kernel/random/uuid)
choose_bug () {
echo -e "   .-----------------------------------."
echo -e "   |       ${blue}Choose Your Trick VPN       \e[0m|"
echo -e "   '-----------------------------------'"
echo -e "     ${blue}1)\e[0m default SNI/Bug location"
echo -e "     ${blue}2)\e[0m reverse Host/Bug as address, Sni & Patch"
echo -e "     ${blue}3)\e[0m reverse SNI/Bug as address"
echo -e "   ------------------------------------"
read -p "   Please select numbers 1-3: " trick
if [[ $trick == "1" ]]; then
tri=DEFAULT
elif [[ $trick == "2" ]]; then
tri=DEFAULT2
elif [[ $trick == "3" ]]; then
tri=DEFAULT3
elif [[ $trick == "" ]]; then
echo -e "${red}Please enter an correct number ${NC}"
sleep 1
choose_bug
else
echo -e "${red}Please enter an correct number ${NC}"
sleep 1
choose_bug
fi
}
choose_bug
if [[ $tri == "DEFAULT" ]]; then
echo ""
read -p "   Bug As Address (Example: www.google.com) : " address
read -p "   Bug SNI/Host (Example : m.facebook.com) : " sni
read -p "   Expired (days) : " masaaktif
bug_addr=${address}.
bug_addr2=$address
if [[ $address == "" ]]; then
sts=$bug_addr2
else
sts=$bug_addr
fi
elif [[ $tri == "DEFAULT2" ]]; then
echo ""
read -p "   Bug As Address (Example: www.google.com) : " address
read -p "   Bug SNI/Patch (Example : m.facebook.com) : " sni
read -p "   Expired (days) : " masaaktif
bug_addr=${address}
bug_addr2=bug.com
if [[ $address == "" ]]; then
sts=$bug_addr2
else
sts=$bug_addr
fi
elif [[ $tri == "DEFAULT3" ]]; then
echo ""
read -p "   Bug As Address (Example: www.google.com) : " address
read -p "   Expired (days) : " masaaktif
bug_addr=${address}
bug_addr2=bug.com
if [[ $address == "" ]]; then
sts=$bug_addr2
else
sts=$bug_addr
fi
else
echo -e "${red}Please enter an correct number ${NC}"
sleep 1
choose_bug
fi
#BUG SNI
bug_sni=bug.com
bug_sni2=${sni}
if [[ $sni == "" ]]; then
stn=${bug_sni}
else
stn=$bug_sni2
fi
#CONFIG
if [[ $tri == "DEFAULT" ]]; then
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
harini=`date -d "0 days" +"%Y-%m-%d"`
sed -i '/#xray-vmess-tls$/a\#vms '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json
echo -e ""
cat>/usr/local/etc/xray/$user-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${sts}${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "$patchtls",
      "type": "none",
      "host": "$domain",
      "tls": "tls",
	  "sni": "$stn"
}
EOF
cat>/usr/local/etc/xray/$user-none.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${sts}${domain}",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "$patchnontls",
      "type": "none",
      "host": "$stn",
      "tls": "none"
}
EOF

cat > /usr/local/etc/xray/$user-clash-for-android.yaml <<-END
# Generated Vmess with Clash For Android
# Generated by EZ-Code
# Credit : Clash For Android

port: 7890
socks-port: 7891
allow-lan: true
mode: Rule
log-level: info
external-controller: :9090
proxies:
  - {name: $user, server: ${sts}$domain, port: $none, type: vmess, uuid: $uuid, alterId: 0, cipher: auto, tls: false, network: ws, ws-opts: {path: $patchnontls, headers: {Host: $stn}}}
proxy-groups:
  - name: 🚀 节点选择
    type: select
    proxies:
      - ♻️ 自动选择
      - DIRECT
      - $user
  - name: ♻️ 自动选择
    type: url-test
    url: http://www.gstatic.com/generate_204
    interval: 300
    proxies:
      - $user
  - name: 🌍 国外媒体
    type: select
    proxies:
      - 🚀 节点选择
      - ♻️ 自动选择
      - 🎯 全球直连
      - $user
  - name: 📲 电报信息
    type: select
    proxies:
      - 🚀 节点选择
      - 🎯 全球直连
      - $user
  - name: Ⓜ️ 微软服务
    type: select
    proxies:
      - 🎯 全球直连
      - 🚀 节点选择
      - $user
  - name: 🍎 苹果服务
    type: select
    proxies:
      - 🚀 节点选择
      - 🎯 全球直连
      - $user
  - name: 📢 谷歌FCM
    type: select
    proxies:
      - 🚀 节点选择
      - 🎯 全球直连
      - ♻️ 自动选择
      - $user
  - name: 🎯 全球直连
    type: select
    proxies:
      - DIRECT
      - 🚀 节点选择
      - ♻️ 自动选择
  - name: 🛑 全球拦截
    type: select
    proxies:
      - REJECT
      - DIRECT
  - name: 🍃 应用净化
    type: select
    proxies:
      - REJECT
      - DIRECT
  - name: 🐟 漏网之鱼
    type: select
    proxies:
      - 🚀 节点选择
      - 🎯 全球直连
      - ♻️ 自动选择
      - $user
END

# masukkan payloadnya ke dalam config yaml
cat /etc/openvpn/server/cll.key >> /usr/local/etc/xray/$user-clash-for-android.yaml

# Copy config Yaml client ke home directory root agar mudah didownload ( YAML )
cp /usr/local/etc/xray/$user-clash-for-android.yaml /home/vps/public_html/$user-clash-for-android.yaml
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmesslink1="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tls.json)"
vmesslink2="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-none.json)"

sed -i '/#xray-vless-tls$/a\#vls '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
vlesslink1="vless://${uuid}@${sts}${domain}:$tls2?path=%2F${patchvtls}&security=tls&encryption=none&host=${domain}&type=ws&sni=${stn}#${user}"
vlesslink2="vless://${uuid}@${sts}${domain}:$none2?path=%2F${patchvtls}&security=none&encryption=none&host=${domain}&type=ws#${user}"
systemctl restart xray
systemctl restart xray@none
service cron restart
clear
echo -e "\e[$line═════[XRAY VMESS & VLESS WEBSOCKET]══════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : $MYIP"
echo -e "Port Tls.      : ${tls}"
echo -e "Port None Tls  : ${none}"
echo -e "User ID        : ${uuid}"
echo -e "Security       : Auto"
echo -e "Network        : Websocket"
echo -e "Support Yaml   : YES"
echo -e "\e[$line═════════════════════════════════════════\e[m"
echo -e "Link Vmess Tls : ${vmesslink1}"
echo -e "\e[$line═════════════════════════════════════════\e[m"
echo -e "Link Vless Tls : ${vlesslink1}"
echo -e "\e[$line═════════════════════════════════════════\e[m"
echo -e "Link Vmess None TLS  : ${vmesslink2}"
echo -e "\e[$line═════════════════════════════════════════\e[m"
echo -e "Link Vless None TLS  : ${vlesslink2}"
echo -e "\e[$line═════════════════════════════════════════\e[m"
echo -e "Link Yaml  : http://$MYIP:81/$user-clash-for-android.yaml"
echo -e "\e[$line═════════════════════════════════════════\e[m"
echo -e "Created   : $harini"
echo -e "Expired   : $exp"
echo -e "Script By $creditt"

elif [[ $tri == "DEFAULT2" ]]; then
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
harini=`date -d "0 days" +"%Y-%m-%d"`
sed -i '/#xray-vmess-tls$/a\#vms '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#xray-vmess-nontls$/a\#vms '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/none.json
cat>/usr/local/etc/xray/$user-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${sts}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "wss://${stn}${patchtls}",
      "type": "none",
      "host": "$domain",
      "tls": "tls",
	    "sni": "$stn"
}
EOF
cat>/usr/local/etc/xray/$user-none.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${sts}",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "wss://${stn}${patchtls}",
      "type": "none",
      "host": "$domain",
      "tls": "none"
}
EOF

cat > /usr/local/etc/xray/$user-clash-for-android.yaml <<-END
# Generated Vmess with Clash For Android
# Generated by EZ-Code
# Credit : Clash For Android

port: 7890
socks-port: 7891
allow-lan: true
mode: Rule
log-level: info
external-controller: :9090
proxies:
  - {name: $user, server: ${sts}, port: $none, type: vmess, uuid: $uuid, alterId: 0, cipher: auto, tls: false, network: ws, ws-opts: {path: $patchnontls, headers: {Host: $domain}}}
proxy-groups:
  - name: 🚀 节点选择
    type: select
    proxies:
      - ♻️ 自动选择
      - DIRECT
      - $user
  - name: ♻️ 自动选择
    type: url-test
    url: http://www.gstatic.com/generate_204
    interval: 300
    proxies:
      - $user
  - name: 🌍 国外媒体
    type: select
    proxies:
      - 🚀 节点选择
      - ♻️ 自动选择
      - 🎯 全球直连
      - $user
  - name: 📲 电报信息
    type: select
    proxies:
      - 🚀 节点选择
      - 🎯 全球直连
      - $user
  - name: Ⓜ️ 微软服务
    type: select
    proxies:
      - 🎯 全球直连
      - 🚀 节点选择
      - $user
  - name: 🍎 苹果服务
    type: select
    proxies:
      - 🚀 节点选择
      - 🎯 全球直连
      - $user
  - name: 📢 谷歌FCM
    type: select
    proxies:
      - 🚀 节点选择
      - 🎯 全球直连
      - ♻️ 自动选择
      - $user
  - name: 🎯 全球直连
    type: select
    proxies:
      - DIRECT
      - 🚀 节点选择
      - ♻️ 自动选择
  - name: 🛑 全球拦截
    type: select
    proxies:
      - REJECT
      - DIRECT
  - name: 🍃 应用净化
    type: select
    proxies:
      - REJECT
      - DIRECT
  - name: 🐟 漏网之鱼
    type: select
    proxies:
      - 🚀 节点选择
      - 🎯 全球直连
      - ♻️ 自动选择
      - $user
END
# masukkan payloadnya ke dalam config yaml
cat /etc/openvpn/server/cll.key >> /usr/local/etc/xray/$user-clash-for-android.yaml

# Copy config Yaml client ke home directory root agar mudah didownload ( YAML )
cp /usr/local/etc/xray/$user-clash-for-android.yaml /home/vps/public_html/$user-clash-for-android.yaml
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmesslink1="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tls.json)"
vmesslink2="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-none.json)"
sed -i '/#xray-vless-tls$/a\#vls '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
vlesslink1="vless://${uuid}@${sts}:$tls2?path=wss%3A%2F%2F${stn}%2F${patchvtls}&security=tls&encryption=none&host=${domain}&type=ws&sni=$stn#${user}"
vlesslink2="vless://${uuid}@${sts}:$none2?path=wss%3A%2F%2F${stn}%2F${patchvtls}&security=none&encryption=none&host=${domain}&type=ws#${user}"
systemctl restart xray
systemctl restart xray@none
clear
echo -e "\e[$line═════[XRAY VMESS & VLESS WEBSOCKET]══════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : $MYIP"
echo -e "Port Tls.      : ${tls}"
echo -e "Port None Tls  : ${none}"
echo -e "User ID        : ${uuid}"
echo -e "Security       : Auto"
echo -e "Network        : Websocket"
echo -e "Support Yaml   : YES"
echo -e "\e[$line═════════════════════════════════════════\e[m"
echo -e "Link Vmess Tls : ${vmesslink1}"
echo -e "\e[$line═════════════════════════════════════════\e[m"
echo -e "Link Vless Tls : ${vlesslink1}"
echo -e "\e[$line═════════════════════════════════════════\e[m"
echo -e "Link Vmess None TLS  : ${vmesslink2}"
echo -e "\e[$line═════════════════════════════════════════\e[m"
echo -e "Link Vless None TLS  : ${vlesslink2}"
echo -e "\e[$line═════════════════════════════════════════\e[m"
echo -e "Link Yaml  : http://$MYIP:81/$user-clash-for-android.yaml"
echo -e "\e[$line═════════════════════════════════════════\e[m"
echo -e "Created   : $harini"
echo -e "Expired   : $exp"
echo -e "Script By $creditt"

elif [[ $tri == "DEFAULT3" ]]; then
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
harini=`date -d "0 days" +"%Y-%m-%d"`
sed -i '/#xray-vmess-tls$/a\#vms '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#xray-vmess-nontls$/a\#vms '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/none.json
cat>/usr/local/etc/xray/$user-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${sts}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "${patchtls}",
      "type": "none",
      "host": "$domain",
      "tls": "tls",
	    "sni": "$domain"
}
EOF
cat>/usr/local/etc/xray/$user-none.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${sts}",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "${patchnontls}",
      "type": "none",
      "host": "$domain",
      "tls": "none"
}
EOF
cat > /usr/local/etc/xray/$user-clash-for-android.yaml <<-END
# Generated Vmess with Clash For Android
# Generated by EZ-Code
# Credit : Clash For Android

port: 7890
socks-port: 7891
allow-lan: true
mode: Rule
log-level: info
external-controller: :9090
proxies:
  - {name: $user, server: ${sts}, port: $none, type: vmess, uuid: $uuid, alterId: 0, cipher: auto, tls: false, network: ws, ws-opts: {path: $patchnontls, headers: {Host: $domain}}}
proxy-groups:
  - name: 🚀 节点选择
    type: select
    proxies:
      - ♻️ 自动选择
      - DIRECT
      - $user
  - name: ♻️ 自动选择
    type: url-test
    url: http://www.gstatic.com/generate_204
    interval: 300
    proxies:
      - $user
  - name: 🌍 国外媒体
    type: select
    proxies:
      - 🚀 节点选择
      - ♻️ 自动选择
      - 🎯 全球直连
      - $user
  - name: 📲 电报信息
    type: select
    proxies:
      - 🚀 节点选择
      - 🎯 全球直连
      - $user
  - name: Ⓜ️ 微软服务
    type: select
    proxies:
      - 🎯 全球直连
      - 🚀 节点选择
      - $user
  - name: 🍎 苹果服务
    type: select
    proxies:
      - 🚀 节点选择
      - 🎯 全球直连
      - $user
  - name: 📢 谷歌FCM
    type: select
    proxies:
      - 🚀 节点选择
      - 🎯 全球直连
      - ♻️ 自动选择
      - $user
  - name: 🎯 全球直连
    type: select
    proxies:
      - DIRECT
      - 🚀 节点选择
      - ♻️ 自动选择
  - name: 🛑 全球拦截
    type: select
    proxies:
      - REJECT
      - DIRECT
  - name: 🍃 应用净化
    type: select
    proxies:
      - REJECT
      - DIRECT
  - name: 🐟 漏网之鱼
    type: select
    proxies:
      - 🚀 节点选择
      - 🎯 全球直连
      - ♻️ 自动选择
      - $user
END
# masukkan payloadnya ke dalam config yaml
cat /etc/openvpn/server/cll.key >> /usr/local/etc/xray/$user-clash-for-android.yaml

# Copy config Yaml client ke home directory root agar mudah didownload ( YAML )
cp /usr/local/etc/xray/$user-clash-for-android.yaml /home/vps/public_html/$user-clash-for-android.yaml
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmesslink1="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tls.json)"
vmesslink2="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-none.json)"
sed -i '/#xray-vless-tls$/a\#vls '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
vlesslink1="vless://${uuid}@${sts}:$tls2?path=%2F${patchvtls}&security=tls&encryption=none&host=${domain}&type=ws&sni=${domain}#${user}"
vlesslink2="vless://${uuid}@${sts}:$none2?path=%2F${patchvtls}&security=none&encryption=none&host=${domain}&type=ws#${user}"
systemctl restart xray
systemctl restart xray@none
clear
echo -e "\e[$line═════[XRAY VMESS & VLESS WEBSOCKET]══════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : $MYIP"
echo -e "Port Tls.      : ${tls}"
echo -e "Port None Tls  : ${none}"
echo -e "User ID        : ${uuid}"
echo -e "Security       : Auto"
echo -e "Network        : Websocket"
echo -e "Support Yaml   : YES"
echo -e "\e[$line═════════════════════════════════════════\e[m"
echo -e "Link Vmess Tls : ${vmesslink1}"
echo -e "\e[$line═════════════════════════════════════════\e[m"
echo -e "Link Vless Tls : ${vlesslink1}"
echo -e "\e[$line═════════════════════════════════════════\e[m"
echo -e "Link Vmess None TLS  : ${vmesslink2}"
echo -e "\e[$line═════════════════════════════════════════\e[m"
echo -e "Link Vless None TLS  : ${vlesslink2}"
echo -e "\e[$line═════════════════════════════════════════\e[m"
echo -e "Link Yaml  : http://$MYIP:81/$user-clash-for-android.yaml"
echo -e "\e[$line═════════════════════════════════════════\e[m"
echo -e "Created   : $harini"
echo -e "Expired   : $exp"
echo -e "Script By $creditt"
else
echo -e "${red}ERROR ${NC}"
sleep 1
fi
