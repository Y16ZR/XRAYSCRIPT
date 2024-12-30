#!/bin/bash
#wget https://github.com/${GitUser}/
GitUser="Y16ZR"
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)

#ACC TROJAN XRAY GRPC TLS
mkdir -p /usr/local/etc/xray/
touch /usr/local/etc/xray/akunxtrgrpc.conf

#AC TROJAN XRAY WS TLS
touch /usr/local/etc/xray/akuntrws.conf

#EMAIL & DOMAIN
emailcf=$(cat /usr/local/etc/xray/email)
domain=$(cat /usr/local/etc/xray/domain)

apt install iptables iptables-persistent -y
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y 
apt install socat cron bash-completion ntpdate -y
ntpdate pool.ntp.org
apt -y install chrony
timedatectl set-ntp true
systemctl enable chronyd && systemctl restart chronyd
systemctl enable chrony && systemctl restart chrony
timedatectl set-timezone Asia/Kuala_Lumpur
chronyc sourcestats -v
chronyc tracking -v
date

echo -e "[ \e[32;1mINFO\e[0m ] INSTALLATION XRAY CORE . . ."

#CHECK VERSION XRAY CORE
latest_version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"

#INSTALLATION XRAY CORE
xraycore_link="https://github.com/XTLS/Xray-core/releases/download/v$latest_version/xray-linux-64.zip"

#MAKE MAIN DIRECTORY XRAY
mkdir -p /usr/bin/xray
mkdir -p /etc/xray

#UNZIP XRAY LINUX 64
cd `mktemp -d`
curl -sL "$xraycore_link" -o xray.zip
unzip -q xray.zip && rm -rf xray.zip
mv xray /usr/local/bin/xray
chmod +x /usr/local/bin/xray

#MAKE FOLDER XRAY
mkdir -p /var/log/xray/

echo -e "[ \e[32;1mINFO\e[0m ] GENERATE CERTIFICATE XRAY CORE . . ."

#STOP PORT 80 SEMENTARA
sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill

#GENERATE CERTIFICATE DOMAIN FOR XRAY
mkdir /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --server letsencrypt \
        --register-account  --accountemail $emailcf
/root/.acme.sh/acme.sh --server letsencrypt --issue -d $domain --standalone -k ec-256			   
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /usr/local/etc/xray/xray.crt --keypath /usr/local/etc/xray/xray.key --ecc
service squid start

#UUID XRAY
uuid=$(cat /proc/sys/kernel/random/uuid)

echo -e "[ \e[32;1mINFO\e[0m ] INSTALLATION CONFIGURATION FOR XRAY CORE . . ."

#MAKE CONFIG XRAY VMESS, VLESS & TROJAN WS TLS
#MAKE CONFIG XRAY VLESS XTLS VISION TLS
#MAKE CONFIG XRAY TROJAN GRPC TLS
cat> /usr/local/etc/xray/config.json  << END
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
       },
    "inbounds": [
        {
            "port": 443,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}",
                        "flow": "xtls-rprx-vision",
                        "level": 0
#xray-vless-xtls
                    }
                ],
                "decryption": "none",
                "fallbacks": [
                    {
                        "alpn": "h2",
                        "dest": 1310,
                        "xver": 0
                    },
                    {
                        "path": "/xray-trojan",
                        "dest": 1313,
                        "xver": 1
                    },
                    {
                        "path": "/xray-vmess",
                        "dest": 1311,
                        "xver": 1
                    },
                    {
                        "path": "/xray-vless",
                        "dest": 1312,
                        "xver": 1
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp",
                "security": "tls",
                "tlsSettings": {
                    "alpn": [
                        "h2",
                        "http/1.1"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "/usr/local/etc/xray/xray.crt",
                            "keyFile": "/usr/local/etc/xray/xray.key"
                        }
                    ]
                }
            }
        },
        {
            "port": 1310,
            "listen": "127.0.0.1",
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}",
                        "password": "xxxxxx"
#xray-trojan-grpc
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "grpc",
                "security": "none",
                "grpcSettings": {
                    "serviceName": "grpc"
                }
            }
        },
        {
            "port": 1311,
            "listen": "127.0.0.1",
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}",
                        "alterId": 0,
                        "level": 0
#xray-vmess-tls
                    }
                ]
            },
            "streamSettings": {
                "network": "ws",
                "security": "none",
                "wsSettings": {
                    "acceptProxyProtocol": true,
                    "path": "/xray-vmess"
                }
            }
        },
        {
            "port": 1313,
            "listen": "127.0.0.1",
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}",
                        "password": "xxxxxx"
#xray-trojan-ws
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none",
                "wsSettings": {
                    "acceptProxyProtocol": true,
                    "path": "/xray-trojan"
                }
            }
        },
        {
            "port": 1312,
            "listen": "127.0.0.1",
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}",
                        "level": 0
#xray-vless-tls
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none",
                "wsSettings": {
                    "acceptProxyProtocol": true,
                    "path": "/xray-vless"
                }
            }
        }
    ],
    "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "type": "field"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  },
  "stats": {},
  "api": {
    "services": [
      "StatsService"
    ],
    "tag": "api"
  },
  "policy": {
    "levels": {
      "0": {
        "statsUserDownlink": true,
        "statsUserUplink": true
      }
    },
    "system": {
      "statsInboundUplink": true,
      "statsInboundDownlink": true
    }
  }
}
END

#MAKE CONFIG XRAY VMESS,VLESS & TROJAN NONE TLS
cat> /usr/local/etc/xray/none.json << END
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
      {
      "port": 80,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}"
          }
        ],
        "decryption": "none",
        "fallbacks": [
          {
              "dest": 1310,
              "xver": 1
          },
          {
              "path": "/xray-vmess",
              "dest": 1311,
              "xver": 1
          },
          {
              "path": "/xray-vless",
              "dest": 1312,
              "xver": 1
          },
          {
              "path": "/xray-trojan",
              "dest": 1313,
              "xver": 1
          }
        ]
      },
      "streamSettings": {
       "network": "tcp",
        "security": "none",
         "tlsSettings": {
          "alpn": ["http/1.1"]
                }
            }
        }
    ],
"outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "type": "field"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  },
  "stats": {},
  "api": {
    "services": [
      "StatsService"
    ],
    "tag": "api"
  },
  "policy": {
    "levels": {
      "0": {
        "statsUserDownlink": true,
        "statsUserUplink": true
      }
    },
    "system": {
      "statsInboundUplink": true,
      "statsInboundDownlink": true,
      "statsOutboundUplink" : true,
      "statsOutboundDownlink" : true
    }
  }
}
END

#Remove Old Service
rm -rf /etc/systemd/system/xray.service.d
rm -rf /etc/systemd/system/xray@.service.d

echo -e "[ \e[32;1mINFO\e[0m ] INSTALLATION XRAY CORE SERVICE . . ."

#START XRAY SERVICE TLS
cat> /etc/systemd/system/xray.service << END
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /usr/local/etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

END

#START XRAY SERVICE NONE TLS
cat> /etc/systemd/system/xray@.service << END
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /usr/local/etc/xray/%i.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

END

iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 1310 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 1311 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 1312 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 1313 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 1310 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 1311 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 1312 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 1313 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

echo -e "[ \e[32;1mINFO\e[0m ] RESTART XRAY CORE . . ."
#ENABLE XRAY TLS
systemctl daemon-reload
systemctl enable xray
systemctl start xray
systemctl restart xray

#ENABLE XRAY NONE TLS
systemctl daemon-reload
systemctl enable xray@none
systemctl start xray@none
systemctl restart xray@none

echo -e "[ \e[32;1mINFO\e[0m ] DOWLOADING TOOLS FOR XRAY . . ."
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

cd
rm -f ins-xray.sh