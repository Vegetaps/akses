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
mkdir /root/backup &>/dev/null
echo -e "${CYAN}[ INFO ] ${BLUE}Mohon Ditunggu... "
cp /etc/passwd backup/ &>/dev/null
cp /etc/group backup/ &>/dev/null
cp /etc/shadow backup/ &>/dev/null
cp /etc/gshadow backup/ &>/dev/null
cp -r /etc/kyt/limit backup/limit &>/dev/null
cp -r /etc/vmess backup/vmess &>/dev/null
cp -r /etc/trojan backup/trojan &>/dev/null
cp -r /etc/vless backup/vless &>/dev/null
cp -r /etc/shadowsock backup/shadowsock &>/dev/null
cp -r /var/lib/kyt/ backup/kyt &>/dev/null
cp -r /etc/xray backup/xray &>/dev/null
cp -r /var/www/html backup/html &>/dev/null
cd /root &>/dev/null
zip -r $IP.zip backup > /dev/null 2>&1
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
echo " Please Check Your BOT"
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
