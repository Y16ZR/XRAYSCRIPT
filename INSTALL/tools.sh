#!/bin/bash
# By EZ-Code
# ==================================================
#wget https://github.com/${GitUser}/
GitUser="${GitUser}"

#DISABLE IPV6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

#INSTALL WGET AND CURL
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt -y install wget curl
apt-get --reinstall --fix-missing install -y bzip2 gzip coreutils wget screen rsyslog iftop htop net-tools zip unzip wget net-tools curl nano sed screen gnupg gnupg1 bc apt-transport-https build-essential dirmngr libxml-parser-perl neofetch git lsof
apt-get remove --purge ufw firewalld -y
apt-get remove --purge exim4 -y

#INSTALL CLOUFLARE JQ
apt install jq curl -y

cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END
cd /etc
mv rc.local rc.local.bkp

# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.
iptables -I INPUT -p udp --dport 5300 -j ACCEPT 
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
cd /etc/slowdns && ./startdns.sh
exit 0
END
#UBAH IZIN AKSES
chmod +x /etc/rc.local

# enable rc local
systemctl enable rc-local
systemctl start rc-local
systemctl start rc-local.service

#SET TIME GMT +8
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime

echo -e "[ \e[32;1mINFO\e[0m ] INSTALLATION BADVPN . . ."
#INSTALL BADVPN
cd
wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/badvpn-udpgw64"
chmod +x /usr/bin/badvpn-udpgw
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500' /etc/rc.local
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500

echo -e "[ \e[32;1mINFO\e[0m ] INSTALLATION WEBSERVE NGINX . . ."

#INSTALL WEBSERVER NGINX
apt -y install nginx
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/nginx.conf"
mkdir -p /home/vps/public_html
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/vps.conf"
/etc/init.d/nginx restart

#SETTING VNSTAT
apt -y install vnstat
/etc/init.d/vnstat restart
apt -y install libsqlite3-dev
wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
rm -f /root/vnstat-2.6.tar.gz
rm -rf /root/vnstat-2.6

#INSTALL FAIL2BAN
apt -y install fail2ban

#INSTAL DDOS FLATE
if [ -d '/usr/local/ddos' ]; then
	echo; echo; echo "Please un-install the previous version first"
	exit 0
else
	mkdir /usr/local/ddos
fi
clear
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to zaf@vsnl.com'

#BLOCK TORRENT
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

clear

#AUTO DELETE USER EXP
echo "0 5 * * * root clear-log" >> /etc/crontab
echo "0 0 * * * root xp" >> /etc/crontab

#AUTO OPEN MENU STARTUP
cd
echo "unset HISTFILE" >> /etc/profile
echo "clear" >> .profile
echo "menu" >> .profile

# remove unnecessary files
cd
apt autoclean -y
apt -y remove --purge unscd
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove bind9*;
apt-get -y remove sendmail*
apt autoremove -y

echo -e "[ \e[32;1mINFO\e[0m ] DOWLOADING PLUGIN FOR XRAY . . ."
#DOWNLOAD COMMAND SCRIPT
#ADD-USER
cd /usr/bin
wget -O add-trojan "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/ADD-USER/add-trojan.sh"
wget -O add-tr "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/ADD-USER/add-tr.sh"
wget -O add-vmess "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/ADD-USER/add-vmess.sh"
wget -O add-vless "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/ADD-USER/add-vless.sh"
chmod +x add-trojan
chmod +x add-tr
chmod +x add-vmess
chmod +x add-vless

#TRIAL USER
wget -O trial-trojan "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/TRIAL-USER/trial-trojan.sh"
wget -O trial-tr "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/TRIAL-USER/trial-tr.sh"
wget -O trial-vmess "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/TRIAL-USER/trial-vmess.sh"
wget -O trial-vless "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/TRIAL-USER/trial-vless.sh"
chmod +x trial-trojan
chmod +x trial-tr
chmod +x trial-vmess
chmod +x trial-vless

#DELETE USER
wget -O delete-trojan "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/DELETE-USER/delete-trojan.sh"
wget -O delete-tr "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/DELETE-USER/delete-tr.sh"
wget -O delete-vmess "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/DELETE-USER/delete-vmess.sh"
wget -O delete-vless "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/DELETE-USER/delete-vless.sh"
chmod +x delete-trojan
chmod +x delete-tr
chmod +x delete-vmess
chmod +x delete-vless

#CHECK USER
wget -O check-trojan "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/CHECK-USER/check-trojan.sh"
wget -O check-tr "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/CHECK-USER/check-tr.sh"
wget -O check-vmess "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/CHECK-USER/check-vmess.sh"
wget -O check-vless "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/CHECK-USER/check-vless.sh"
chmod +x check-trojan
chmod +x check-tr
chmod +x check-vmess
chmod +x check-vless

#RENEW USER
wget -O renew-trojan "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/RENEW-USER/renew-trojan.sh"
wget -O renew-vmess "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/RENEW-USER/renew-vmess.sh"
wget -O renew-vless "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/RENEW-USER/renew-vless.sh"
wget -O renew-tr "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/RENEW-USER/renew-tr.sh"
chmod +x renew-trojan
chmod +x renew-tr
chmod +x renew-vmess
chmod +x renew-vless

#SHOW USER
wget -O show-trojan "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/SHOW-USER/show-trojan.sh"
wget -O show-tr "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/SHOW-USER/show-tr.sh"
wget -O show-vmess "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/SHOW-USER/show-vmess.sh"
wget -O show-vless "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/SHOW-USER/show-vless.sh"
chmod +x show-trojan
chmod +x show-tr
chmod +x show-vmess
chmod +x show-vless

#ANY TOOLS
wget -O port-xray "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/CHANGE-PORT/port-xray.sh"
wget -O cert "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/cert.sh"
wget -O x-trojan "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/MENU/x-trojan.sh"
wget -O x-tr "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/MENU/x-tr.sh"
wget -O x-vmess "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/MENU/x-vmess.sh"
wget -O x-vless "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/MENU/x-vless.sh"
wget -O xray-update "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/SYSTEM/xray-update.sh"
chmod +x port-xray
chmod +x cert
chmod +x x-trojan
chmod +x x-tr
chmod +x x-vmess
chmod +x x-vless
chmod +x xray-update

#ANY TOOLS
wget -O add-host "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/SYSTEM/add-host.sh"
wget -O about "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/SYSTEM/about.sh"
wget -O menu "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/menu.sh"
wget -O menu-br "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/MENU/menu-br.sh"
wget -O speedtest "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/SYSTEM/speedtest_cli.py"
wget -O info "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/SYSTEM/info.sh"
wget -O clear-log "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/clear-log.sh"
wget -O change-port "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/change.sh"
wget -O wbmn "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/webmin.sh"
wget -O ram "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/SYSTEM/ram.sh"
wget -O xp "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/xp.sh"
wget -O cfa "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/CLOUD/cfa.sh"
wget -O cfd "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/CLOUD/cfd.sh"
wget -O cfp "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/CLOUD/cfp.sh"
wget -O swap "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/swapkvm.sh"
wget -O check-sc "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/SYSTEM/running.sh"
wget -O autoreboot "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/SYSTEM/autoreboot.sh"
wget -O port-xray "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/CHANGE-PORT/port-xray.sh"
wget -O menu-domain "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/MENU/menu-domain.sh"
wget -O script-update "https://raw.githubusercontent.com/${GitUser}/XRAYSCRIPT/main/script-updatesc.sh"
wget -O restart "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTFALLBACK/main/SYSTEM/restart.sh"
chmod +x add-host
chmod +x menu
chmod +x menu-br
chmod +x menu-domain
chmod +x ram
chmod +x restart
chmod +x speedtest
chmod +x info
chmod +x about
chmod +x clear-log
chmod +x change-port
chmod +x wbmn
chmod +x xp
chmod +x cfa
chmod +x cfd
chmod +x cfp
chmod +x swap
chmod +x check-sc
chmod +x autoreboot
chmod +x port-xray
chmod +x menu-domain
chmod +x script-update
chmod +x restart


# finishing
cd
chown -R www-data:www-data /home/vps/public_html
/etc/init.d/nginx restart
/etc/init.d/cron restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/vnstat restart
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500
