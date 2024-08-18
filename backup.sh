#!/bin/bash
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
ipsaya=$(wget -qO- ifconfig.me)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://raw.githubusercontent.com/Vegetaps/akses/main/ip"
IP=$(curl -sS ipv4.icanhazip.com);
date=$(date +"%Y-%m-%d")
time=$(date +'%H:%M:%S')
domain=$(cat /etc/xray/domain)
token=$(grep -E "^#bot# " "/etc/bot/.bot.db" | cut -d ' ' -f 2)
id_chat=$(grep -E "^#bot# " "/etc/bot/.bot.db" | cut -d ' ' -f 3)
clear
sleep 1
echo -e "${CYAN}[ INFO ] ${BLUE}Processing... "
echo -e "${CYAN}[ INFO ] ${BLUE}Mohon Ditunggu... "
rm -rf /root/backup
mkdir /root/backup
cp /etc/passwd backup/
cp /etc/group backup/
cp /etc/shadow backup/
cp /etc/gshadow backup/
cp /etc/crontab backup/
cp /etc/vmess/.vmess.db backup/
cp /etc/ssh/.ssh.db backup/
cp /etc/vless/.vless.db backup/
cp /etc/trojan/.trojan.db backup/
cp /etc/shadowsocks/.shadowsocks.db backup/
cp -r /etc/kyt/limit backup/
cp -r /etc/vmess backup/
cp -r /etc/trojan backup/
cp -r /etc/vless backup/
cp -r /etc/shadowsock backup/
cp -r /var/lib/kyt/ backup/kyt 
cp -r /etc/xray backup/xray
cp -r /var/www/html/ backup/html
cd /root
zip -r $IP-$date.zip backup > /dev/null 2>&1
rclone copy /root/$IP-$date.zip dr:backup/
url=$(rclone link dr:backup/$IP-$date.zip)
id=(`echo $url | grep '^https' | cut -d'=' -f2`)
link="https://drive.google.com/u/4/uc?id=${id}&export=download"
curl -F chat_id="$id_chat" -F document=@"$IP.zip" -F caption="Thank You For Using this Script
Domain : $domain
IP VPS : $IP
Date   : $date
Time   : $time WIB
Link   : $link" https://api.telegram.org/bot$token/sendDocument &> /dev/null
rm -rf /root/backup
rm -r /root/$IP-$date.zip
echo -e "
Detail Backup 
==================================
IP VPS        : $IP
Link Backup   : $link
Tanggal       : $date
==================================
"
read -n 1 -s -r -p "Press any key to back on menu"
menu
