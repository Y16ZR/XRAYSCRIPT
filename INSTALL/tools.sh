#!/bin/bash
# By EZ-Code
# ==================================================

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

#DISABLE IPV6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

#SET TIME GMT +8
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime

echo -e "[ \e[32;1mINFO\e[0m ] INSTALLATION WEBSERVE NGINX . . ."

#INSTALL WEBSERVER NGINX
apt -y install nginx
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/Y16ZR/XRAYSCRIPT/main/nginx.conf"
mkdir -p /home/vps/public_html
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/Y16ZR/XRAYSCRIPT/main/vps.conf"
/etc/init.d/nginx restart
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
