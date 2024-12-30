#!/bin/bash
clear
echo -e ""
echo -e "======================================"
echo -e "         \e[0;32mRESTART VPN SERVICE\e[0m"
echo -e "======================================"
echo -e "  \e[0;32m[•1]\e[0m Restart All Services"
echo -e "  \e[0;32m[•2]\e[0m Restart Nginx"
echo -e "  \e[0;32m[•3]\e[0m Restart Xray Core"
echo -e "  \e[0;32m[•4]\e[0m Restart Badvpn"
echo -e "======================================"
echo -e "   \e[0;32m[x]\e[0m     \e[1;31mMain Menu\e[0m"
echo -e ""
read -p "    Select From Options [1-14 or x] :" Restart
echo -e ""
echo -e "======================================"
sleep 1
clear
case $Restart in
                1)
                clear
                /etc/init.d/fail2ban restart
                /etc/init.d/cron restart
                /etc/init.d/nginx restart
				systemctl restart xray
				systemctl restart xray@none
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "          \e[0;32mALL Service Restarted\e[0m         "
                echo -e ""
                echo -e "======================================"
                exit
                ;;
                2)
                clear
                /etc/init.d/nginx restart
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "         \e[0;32mNginx Service Restarted\e[0m      "
                echo -e ""
                echo -e "======================================"
                exit
                ;;
				3)
                clear
				systemctl restart xray
				systemctl restart xray@none
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "         \e[0;32mXray Service Restart\e[0m         "
                echo -e ""
                echo -e "======================================"
                exit
                ;;
                4)
                clear
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "       \e[0;32mBadvpn Service Restarted\e[0m     "
                echo -e ""
                echo -e "======================================"
                exit
                ;;
                x)
                clear
                menu
                ;;
                esac