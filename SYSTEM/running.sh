#!/bin/bash
red="\e[1;31m"
green="\e[0;32m"
NC="\e[0m"
clear
GitUser="EZ-Code00"
# VPS Information
Checkstart1=$(ip route | grep default | cut -d ' ' -f 3 | head -n 1);
if [[ $Checkstart1 == "venet0" ]]; then 
    clear
	  lan_net="venet0"
    typevps="OpenVZ"
    sleep 1
else
    clear
		lan_net="eth0"
    typevps="KVM"
    sleep 1
fi
MYIP=$(wget -qO- icanhazip.com);
echo -e "\e[32mloading...\e[0m"
clear
# VPS ISP INFORMATION
ITAM='\033[0;30m'
echo -e "$ITAM"
NAMAISP=$( curl -s ipinfo.io/org | cut -d " " -f 2-10  )
REGION=$( curl -s ipinfo.io/region )
#clear
COUNTRY=$( curl -s ipinfo.io/country )
#clear
WAKTU=$( curl -s ipinfo.ip/timezone )
#clear
CITY=$( curl -s ipinfo.io/city )
#clear
REGION=$( curl -s ipinfo.io/region )
#clear
WAKTUE=$( curl -s ipinfo.io/timezone )
#clear
koordinat=$( curl -s ipinfo.io/loc )

# TOTAL RAM
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
fram=$( free -m | awk 'NR==2 {print $4}' )
swap=$( free -m | awk 'NR==4 {print $2}' )

#clear
NC='\033[0m'
echo -e "$NC"

# USERNAME
rm -f /usr/bin/user
username=$( curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $2}' )
echo "$username" > /usr/bin/user

# Order ID
rm -f /usr/bin/ver
user=$( curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $3}' )
echo "$user" > /usr/bin/ver

# validity
rm -f /usr/bin/e
valid=$( curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}' )
echo "$valid" > /usr/bin/e
clear
# DETAIL ORDER
username=$(cat /usr/bin/user)
oid=$(cat /usr/bin/ver)
exp=$(cat /usr/bin/e)

# Tipe Processor
totalcore="$(grep -c "^processor" /proc/cpuinfo)" 
totalcore+=" Core"
corediilik="$(grep -c "^processor" /proc/cpuinfo)" 
tipeprosesor="$(awk -F ': | @' '/model name|Processor|^cpu model|chip type|^cpu type/ {
                        printf $2;
                        exit
                        }' /proc/cpuinfo)"

# Shell Version
shellversion=""
shellversion=Bash
shellversion+=" Version" 
shellversion+=" ${BASH_VERSION/-*}" 
versibash=$shellversion

# Getting OS Information
source /etc/os-release
Versi_OS=$VERSION
ver=$VERSION_ID
Tipe=$NAME
URL_SUPPORT=$HOME_URL
basedong=$ID
clear
# Download
download=`grep -e "lo:" -e "wlan0:" -e "eth0" /proc/net/dev  | awk '{print $2}' | paste -sd+ - | bc`
downloadsize=$(($download/1073741824))

# Upload
upload=`grep -e "lo:" -e "wlan0:" -e "eth0" /proc/net/dev | awk '{print $10}' | paste -sd+ - | bc`
uploadsize=$(($upload/1073741824))

# Getting CPU Information
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"

# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"

# Kernel Terbaru
kernelku=$(uname -r)

# Waktu Sekarang 
harini=`date -d "0 days" +"%d-%m-%Y"`
jam=`date -d "0 days" +"%X"`

# DNS Patch
tipeos2=$(uname -m)

# Getting Domain Name
Domen="$(cat /usr/local/etc/xray/domain)"
# Echoing Result
echo -e "\e[32mloading...\e[0m"
clear
echo -e ""
echo -e "              \e[1;92mYOUR SERVER INFORMATION\e[0m"
echo -e "               \e[1;92mSCRIPT VPS \e[1;96mBY EZ-CODE\e[0m"
echo -e "\e[0;33m-----------------------------------------------------------"
echo -e "                   \e[1;92mOPERATING SYSTEM\e[0m"
echo -e "  ${green}VPS Type      :${NC} $typevps"
echo -e "  ${green}OS Arch       :${NC} $tipeos2"
echo -e "  ${green}Hostname      :${NC} $HOSTNAME"
echo -e "  ${green}OS Name       :${NC} $Tipe"
echo -e "  ${green}OS Version    :${NC} $Versi_OS"
echo -e "  ${green}OS URL        :${NC} $URL_SUPPORT"
echo -e "  ${green}OS BASE       :${NC} $basedong"
echo -e "  ${green}OS TYPE       :${NC} Linux / Unix"
echo -e "  ${green}Bash Ver      :${NC} $versibash"
echo -e "  ${green}Kernel Ver    :${NC} $kernelku"
echo -e "\e[0;33m-----------------------------------------------------------"
echo -e "                      \e[1;92mHARDWARE\e[0m"
echo -e "  ${green}Processor     :${NC} $tipeprosesor"
echo -e "  ${green}Proc Core     :${NC} $totalcore"
echo -e "  ${green}Virtual       :${NC} $typevps"
echo -e "  ${green}Cpu Usage     :${NC} $cpu_usage"
echo -e "\e[0;33m-----------------------------------------------------------"
echo -e "                 \e[1;92mSYSTEM STATUS USED"
echo -e "  ${green}Uptime        :${NC} $uptime ( From VPS Booting )"
echo -e "  ${green}Total RAM     :${NC} $tram MB"
echo -e "  ${green}Used RAM      :${NC} $uram MB"
echo -e "  ${green}Avaible RAM   :${NC} $fram MB"
echo -e "  ${green}Download      :${NC} $downloadsize GB ( From Startup/VPS Booting )"
echo -e "  ${green}Upload        :${NC} $uploadsize GB ( From Startup/VPS Booting )"
echo -e "\e[0;33m-----------------------------------------------------------"
echo -e "              \e[1;92mINTERNET SERVICE PROVIDER"
echo -e "  ${green}Public IP     :${NC} $MYIP"
echo -e "  ${green}Domain        :${NC} $Domen"
echo -e "  ${green}ISP Name      :${NC} $NAMAISP"
echo -e "  ${green}Region        :${NC} $REGION "
echo -e "  ${green}Country       :${NC} $COUNTRY"
echo -e "  ${green}City          :${NC} $CITY "
echo -e "  ${green}Time Zone     :${NC} $WAKTUE"
echo -e "${green}\e[0;33m-----------------------------------------------------------"
echo -e "          \e[1;92mTIME & DATE & LOCATION & COORDINATE"
echo -e "  ${green}Location      :${NC} $COUNTRY"
echo -e "  ${green}Coordinate    :${NC} $koordinat"
echo -e "  ${green}Time Zone     :${NC} $WAKTUE"
echo -e "  ${green}Date          :${NC} $harini"
echo -e "  ${green}Time          :${NC} $jam ( WIB )"
echo -e "\e[0;33m-----------------------------------------------------------"
echo -e "                     \e[1;32mSTATUS SCRIPT\e[0m"
echo -e "  \e[1;36mUser          :\e[0m $username"
echo -e "  \e[1;36mOrder ID      :\e[0m $oid"
echo -e "  \e[1;36mExpired       :\e[0m $exp"
echo -e "\e[0;33m-----------------------------------------------------------"
echo -e ""



# Status SSH
statusssh="$(systemctl show ssh.service --no-page)"
status_textssh=$(echo "${statusssh}" | grep 'ActiveState=' | cut -f2 -d=)
ONSSH="\e[0;32mON\e[0m"
OFFSSH="\e[0;31mOFF\e[0m"
if [ "${status_textssh}" == "active" ]                           
then
ssh=$ONSSH
else
ssh=$OFFSSH
fi

#STATUS OVPN
statusovpn="$(systemctl show --now openvpn-server@server-tcp-1194 --no-page)"
status_textovpn=$(echo "${statusovpn}" | grep 'ActiveState=' | cut -f2 -d=)
ONOVPN="\e[0;32mON\e[0m"
OFFOVPN="\e[0;31mOFF\e[0m"
if [ "${status_textovpn}" == "active" ]                           
then
ovpn=$ONOVPN
else
ovpn=$OFFOVPN
fi

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

#status shadowsocks
statusss="$(systemctl show shadowsocks-libev.service --no-page)"
status_textss=$(echo "${statusss}" | grep 'ActiveState=' | cut -f2 -d=)
ONSS="\e[0;32mON\e[0m"
OFFSS="\e[0;31mOFF\e[0m"
if [ "${status_textss}" == "active" ]                           
then
ss=$ONSS
else
ss=$OFFSS
fi

#status stunnel
statusssl5="$(systemctl show stunnel4.service --no-page)"
status_textssl5=$(echo "${statusssl5}" | grep 'ActiveState=' | cut -f2 -d=)
ONSS="\e[0;32mON\e[0m"
OFFSS="\e[0;31mOFF\e[0m"
if [ "${status_textssl5}" == "active" ]                           
then
ssl5=$ONSS
else
ssl5=$OFFSS
fi

#Status dropbear
statusd="$(systemctl show dropbear.service --no-page)"
status_textd=$(echo "${statusd}" | grep 'ActiveState=' | cut -f2 -d=)
ONSS="\e[0;32mON\e[0m"
OFFSS="\e[0;31mOFF\e[0m"
if [ "${status_textssl5}" == "active" ]                           
then
drop=$ONSS
else
drop=$OFFSS
fi

#status ssh ws http
statushttp="$(systemctl show ws-http.service --no-page)"
status_texthttp=$(echo "${statushttp}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_texthttp}" == "active" ]
ONSS="\e[0;32mON\e[0m"
OFFSS="\e[0;31mOFF\e[0m"                         
then
http=$ONSS
else
http=$OFFSS
fi

#status ssh ws https
statushttps="$(systemctl show ws-https.service --no-page)"
status_texthttps=$(echo "${statushttps}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_texthttps}" == "active" ]
ONSS="\e[0;32mON\e[0m"
OFFSS="\e[0;31mOFF\e[0m"                         
then
https=$ONSS
else
https=$OFFSS
fi

#status ws ovpn
statuswsovpn="$(systemctl show cdn-ovpn.service --no-page)"
status_textwsovpn=$(echo "${statuswsovpn}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_textwsovpn}" == "active" ]
ONSS="\e[0;32mON\e[0m"
OFFSS="\e[0;31mOFF\e[0m"                         
then
wsovpn=$ONSS
else
wsovpn=$OFFSS
fi

#status ohp ssh
statusohpssh="$(systemctl show ohps.service --no-page)"
status_textohpssh=$(echo "${statusohpssh}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_textohpssh}" == "active" ]
ONSS="\e[0;32mON\e[0m"
OFFSS="\e[0;31mOFF\e[0m"                         
then
ohpssh=$ONSS
else
ohpssh=$OFFSS
fi

#status ohp dropbear
statusohpd="$(systemctl show ohpd.service --no-page)"
status_textohpd=$(echo "${statusohpd}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_textohpd}" == "active" ]
ONSS="\e[0;32mON\e[0m"
OFFSS="\e[0;31mOFF\e[0m"                         
then
ohpd=$ONSS
else
ohpd=$OFFSS
fi

#status ohp ovpn
statusohpovpn="$(systemctl show ohp.service --no-page)"
status_textohpovpn=$(echo "${statusohpovpn}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
ONSS="\e[0;32mON\e[0m"
OFFSS="\e[0;31mOFF\e[0m"                         
then
ohpovpn=$ONSS
else
ohpovpn=$OFFSS
fi

#status shadowsocksR
statusssr="$(systemctl show ssrmu --no-page)"
status_textssr=$(echo "${statusssr}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_textssr}" == "active" ]
ONSS="\e[0;32mON\e[0m"
OFFSS="\e[0;31mOFF\e[0m"                         
then
ssr=$ONSS
else
ssr=$OFFSS
fi

#status wg
statuswg="$(systemctl show wg-quick@wg0 --no-page)"
status_textwg=$(echo "${statuswg}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_textwg}" == "active" ]
ONSS="\e[0;32mON\e[0m"
OFFSS="\e[0;31mOFF\e[0m"                         
then
wg=$ONSS
else
wg=$OFFSS
fi

#status nginx
statusnginx="$(systemctl show nginx.service --no-page)"
status_textnginx=$(echo "${statusnginx}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_textnginx}" == "active" ]
ONSS="\e[0;32mON\e[0m"
OFFSS="\e[0;31mOFF\e[0m"                         
then
nginx=$ONSS
else
nginx=$OFFSS
fi

#status squid
statussqd="$(systemctl show squid.service --no-page)"
status_textsqd=$(echo "${statussqd}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_textsqd}" == "active" ]
ONSS="\e[0;32mON\e[0m"
OFFSS="\e[0;31mOFF\e[0m"                         
then
sqd=$ONSS
else
sqd=$OFFSS
fi
echo -e "              \e[0;32m[\e[1;36mSYSTEM STATUS INFORMATION\e[0;32m]\e[0m"
echo -e "             ${green}=============================\e[0m"
echo -e ""
echo -e "    \e[0;33mSSH : $ssh   \e[0;33mOVPN : $ovpn   \e[0;33mXRAY : $xray   \e[0;33mSS : $xray"
echo ""
echo -e "    \e[0;33mSTUNNEL : $ssl5   \e[0;33mDROPBEAR : $drop   \e[0;33mSSH HTTP : $http "
echo ""
echo -e "    \e[0;33mSSH HTTPS : $https   \e[0;33mWS OVPN : $wsovpn   \e[0;33mOHP SSH : $ohpssh "
echo ""
echo -e "    \e[0;33mOHP DROPBEAR : $ohpd   \e[0;33mOHP OVPN : $wsovpn   \e[0;33mSSR : $ssr "
echo ""
echo -e "    \e[0;33mWIREGUARD : $wg   \e[0;33mWEB NGINX : $nginx   \e[0;33mSQUID : $ssr "
echo ""
echo -e "\e[1;36m---------------------------------------------------------\e[0m"
echo -e "   ${green}NOTED:${NC} ${red}ANY REPORT FOR BUG OR SYSTEM OFF OR SCRIPT ERROR${NC}"
echo -e "     ${red}YOU CAN CONTACT ADMIN ON${NC} \e[0;94mTELEGRAM @EzcodeShop"
echo -e ""