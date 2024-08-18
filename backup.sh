#!/bin/bash

# Variabel warna
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'

# Variabel tanggal, IP, domain, dan token
biji=$(date +"%Y-%m-%d")
ipsaya=$(wget -qO- ifconfig.me)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://raw.githubusercontent.com/Vegetaps/akses/main/ip"
IP=$(curl -sS ipv4.icanhazip.com)
date=$(date +"%Y-%m-%d")
time=$(date +'%H:%M:%S')
domain=$(cat /etc/xray/domain)
token=$(grep -E "^#bot# " "/etc/bot/.bot.db" | cut -d ' ' -f 2)
id_chat=$(grep -E "^#bot# " "/etc/bot/.bot.db" | cut -d ' ' -f 3)

# Bersihkan layar dan tampilkan pesan
clear
sleep 1
echo -e "${CYAN}[ INFO ] ${BLUE}Processing... "
echo -e "${CYAN}[ INFO ] ${BLUE}Mohon Ditunggu... "

# Buat direktori backup jika belum ada, dan hapus direktori jika sudah ada
rm -rf /root/backup
mkdir -p /root/backup

# Salin file-file ke direktori backup
cp /etc/passwd /root/backup/
cp /etc/group /root/backup/
cp /etc/shadow /root/backup/
cp /etc/gshadow /root/backup/
cp /etc/crontab /root/backup/
cp /etc/vmess/.vmess.db /root/backup/
cp /etc/ssh/.ssh.db /root/backup/
cp /etc/vless/.vless.db /root/backup/
cp /etc/trojan/.trojan.db /root/backup/
cp /etc/shadowsocks/.shadowsocks.db /root/backup/
cp -r /etc/kyt/limit /root/backup/
cp -r /etc/vmess /root/backup/
cp -r /etc/trojan /root/backup/
cp -r /etc/vless /root/backup/
cp -r /etc/shadowsock /root/backup/
cp -r /var/lib/kyt/ /root/backup/kyt
cp -r /etc/xray /root/backup/xray
cp -r /var/www/html/ /root/backup/html

# Zip direktori backup
cd /root
zip -r "${IP}-${date}.zip" backup > /dev/null 2>&1

# Upload ke Google Drive menggunakan rclone
rclone copy "/root/${IP}-${date}.zip" dr:backup/
url=$(rclone link dr:backup/"${IP}-${date}.zip")
id=$(echo $url | grep '^https' | cut -d'=' -f2)
link="https://drive.google.com/u/4/uc?id=${id}&export=download"

# Kirim file backup ke Telegram
curl -F chat_id="$id_chat" -F document=@"${IP}-${date}.zip" -F caption="Thank You For Using this Script
Domain : $domain
IP VPS : $IP
Date   : $date
Time   : $time WIB
Link   : $link" https://api.telegram.org/bot$token/sendDocument &> /dev/null

# Hapus file backup lokal
rm -rf /root/backup
rm -f "/root/${IP}-${date}.zip"

# Tampilkan detail backup
echo -e "
Detail Backup 
==================================
IP VPS        : $IP
Tanggal       : $date
Link Backup   : $link
==================================
"

# Tunggu input user untuk kembali ke menu
read -n 1 -s -r -p "Press any key to back on menu"
menu
