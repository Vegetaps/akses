#!/bin/bash
######################################
MYIP=$(curl -sS ipv4.icanhazip.com)
######################################
cpu_load=$(uptime | awk -F'load average:' '{print $2}' | cut -d, -f1)
cpu_load_percent=$(echo "scale=2; $cpu_load * 100 / $(nproc)" | bc)
NC="\e[0m"
WH='\033[1;37m'
COLOR1='\033[0;36m'
clear
# // Gettings Info
######################################
# // USERNAME IZIN IPP
rm -f /usr/bin/user
username=$(curl -sS https://raw.githubusercontent.com/Vegetaps/akses/main/ip | grep $MYIP | awk '{print $2}')
echo "$username" >/usr/bin/user
rm -f /usr/bin/e
valid=$(curl -sS https://raw.githubusercontent.com/Vegetaps/akses/main/ip | grep $MYIP | awk '{print $3}')
echo "$valid" > /usr/bin/e

clear
######################################
# // DETAIL ORDER IZIN IP
#username=$(cat /usr/bin/user)
oid=$(cat /usr/bin/ver)
exp=$(cat /usr/bin/e)
######################################
clear
# // DAYS LEFT
d1=$(date -d "$valid" +%s)
d2=$(date -d "$today" +%s)
#certifacate=$(((d1 - d2) / 86400))
clear
######################################
# // GETTINGS SYSTEM
ssh_service=$(/etc/init.d/ssh status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

dropbear_service=$(/etc/init.d/dropbear status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

haproxy_service=$(systemctl status haproxy | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

xray_service=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

nginx_service=$(systemctl status nginx | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

noobz_service=$( systemctl status noobzvpns | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )

clear
######################################
# // RUNNING SSH
######################################
if [[ $ssh_service == "running" ]]; then 
   status_ssh="\033[0;36mON${NC}"
else
   status_ssh="\033[35mOFF${NC} "
fi
######################################
# // RUNNING WEBSOCKET
######################################
ssh_ws=$( systemctl status ws | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $ssh_ws == "running" ]]; then
    status_ws_epro="\033[0;36mON${NC}"
else
    status_ws_epro="\033[35mOFF${NC} "
fi
######################################
# RUNNING HAPROXY
######################################
if [[ $haproxy_service == "running" ]]; then 
   status_haproxy="\033[0;36mON${NC}"
else
   status_haproxy="\033[35mOFF${NC} "
fi
######################################
# RUNNING XRAY
######################################
if [[ $xray_service == "running" ]]; then 
   status_xray="\033[0;36mON${NC}"
else
   status_xray="\033[35mOFF${NC} "
fi
######################################
# RUNNING NGINX
######################################
if [[ $nginx_service == "running" ]]; then 
   status_nginx="\033[0;36mON${NC}"
else
   status_nginx="\033[35mOFF${NC} "
fi
######################################
# RUNNING DROPBEAR
######################################
if [[ $dropbear_service == "running" ]]; then 
   status_dropbear="\033[0;36mON${NC}"
else
   status_dropbear="\033[35mOFF${NC} "
fi
######################################
# RUNNING NOOBZVPN 
######################################
if [[ $noobz_service == "running" ]]; then 
   status_noobz="\033[0;36mON${NC}"
else
   status_noobz="\033[35mOFF${NC} "
fi
# \\ Vless account //
vlx=$(grep -c -E "^#& " "/etc/xray/config.json")
let vla=$vlx/2
# \\ Vmess account //
vmc=$(grep -c -E "^### " "/etc/xray/config.json")
let vma=$vmc/2
# \\ Trojan account //
ssh1="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
trx=$(grep -c -E "^#! " "/etc/xray/config.json")
let trb=$trx/2
# \\ shadowsocks account //
ssx=$(grep -c -E "^#!# " "/etc/xray/config.json")
let ssa=$ssx/2

# \\ Bandwidth
vnstat_profile=$(vnstat | sed -n '3p' | awk '{print $1}' | grep -o '[^:]*')
vnstat -i ${vnstat_profile} >/etc/t1
bulan=$(date +%b)
tahun=$(date +%y)
ba=$(curl -s https://pastebin.com/raw/0gWiX6hE)
today=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $8}')
todayd=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $8}')
today_v=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $9}')
today_rx=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $2}')
today_rxv=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $3}')
today_tx=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $5}')
today_txv=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $6}')
if [ "$(grep -wc ${bulan} /etc/t1)" != '0' ]; then
bulan=$(date +%b)
month=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $9}')
month_v=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $10}')
month_rx=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $3}')
month_rxv=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $4}')
month_tx=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $6}')
month_txv=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $7}')
else
bulan2=$(date +%Y-%m)
month=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $8}')
month_v=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $9}')
month_rx=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $2}')
month_rxv=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $3}')
month_tx=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $5}')
month_txv=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $6}')
fi
if [ "$(grep -wc yesterday /etc/t1)" != '0' ]; then
yesterday=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $8}')
yesterday_v=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $9}')
yesterday_rx=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $2}')
yesterday_rxv=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $3}')
yesterday_tx=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $5}')
yesterday_txv=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $6}')
else
yesterday=NULL
yesterday_v=NULL
yesterday_rx=NULL
yesterday_rxv=NULL
yesterday_tx=NULL
yesterday_txv=NULL
fi

function paintechvpn() {
  clear
  echo -e "\033[0;36m┌─────────────────────────────────────────────────┐\033[0m"
  echo -e "\033[0;36m│\033[0m \033[46m\033[1;37m                  $(cat /etc/xray/username)                  \033[0m\033[0;36m│\033[0m"
  echo -e "\033[0;36m└─────────────────────────────────────────────────┘\033[0m"
}

function Service_System_Operating() {
  echo -e "\033[0;36m┌─────────────────────────────────────────────────┐\033[0m"
  echo -e "\033[0;36m│ \033[0;37m SYSTEM          : \033[0;36m $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g')\033[0m"
  echo -e "\033[0;36m│ \033[0;37m RAM             : \033[0;36m $(free -m | awk 'NR==2 {print $2}')\033[0m"
  echo -e "\033[0;36m│ \033[0;37m Load CPU        : \033[0;36m $cpu_load_percent%\033[0m"
  echo -e "\033[0;36m│ \033[0;37m UPTIME          : \033[0;36m $(uptime -p | cut -d " " -f 2-10)\033[0m"
  echo -e "\033[0;36m│ \033[0;37m ISP             : \033[0;36m $(cat /etc/xray/isp)\033[0m"
  echo -e "\033[0;36m│ \033[0;37m IP VPS          : \033[0;36m $(curl -s ipv4.icanhazip.com)\033[0m"
  echo -e "\033[0;36m│ \033[0;37m DOMAIN          : \033[0;36m $(cat /etc/xray/domain)\033[0m"
  echo -e "\033[0;36m│ \033[0;37m CLIENT          : \033[0;36m $(cat /usr/bin/user)\033[0m"
  echo -e "\033[0;36m│ \033[0;37m EXPIRED         : \033[0;36m $(((d1 - d2) / 86400)) Day\033[0m"
  echo -e "\033[0;36m│ \033[0;37m VERSION         : \033[0;36m Premium V.1.0\033[0m"
  echo -e "\033[0;36m└─────────────────────────────────────────────────┘\033[0m"
}

function Service_Status() {
echo -e " ${COLOR1}╭────────────────────────────────────────────────╮${NC}"
echo -e "  ${WH} SSH WS : $status_ws_epro ${WH} XRAY : $status_xray ${WH} NGINX : $status_nginx ${WH} PROXY : $status_haproxy${NC}"
echo -e "            ${WH}  NOOBZVPNS : $status_noobz  ${WH} DROPBEAR : $status_dropbear$NC"
echo -e " ${COLOR1}╰────────────────────────────────────────────────╯${NC}"
}

function List_All_Account() {
  echo -e "          ${COLOR1}╭───────────────────────────╮${NC}"
echo -e "         ${COLOR1}$NC${WH}      LIST ACCOUNT PREMIUM ${NC}"
echo -e "         ${COLOR1}      ──────────────────── ${NC}"
echo -e "          ${COLOR1}$NC${WH}  SSH/NOOBZ   =  ${COLOR1}$ssh1 ${NC}${WH} Account ${NC}"
echo -e "          ${COLOR1}$NC${WH}  VMESS/WS    =  ${COLOR1}$vma ${NC}${WH} Account ${NC}"
echo -e "          ${COLOR1}$NC${WH}  VLESS/WS    =  ${COLOR1}$vla ${NC}${WH} Account ${NC}"
echo -e "          ${COLOR1}$NC${WH}  TROJAN/GRPC =  ${COLOR1}$trb ${NC}${WH} Account ${NC}"
echo -e "          ${COLOR1}$NC${WH}  SSR-LIBEV   =  ${COLOR1}$ssa ${NC}${WH} Account ${NC}"
echo -e "          ${COLOR1}╰────────────────────────────╯${NC}"
}

function Details_Bw_Clients() {
  echo -e "\033[0;36m   ┌───────────────────────────────────────────┐\033[0m"
  echo -e "\033[0;36m   │  \033[1;37m HARI INI   |  KEMARIN   |  BULANAN\033[0m" 
  echo -e "\033[0;36m   │\033[0;36m──────────────────────────────────────── \033[0m"
  echo -e "\033[0;36m   │  \033[0;36m${COLOR1}$today_tx $today_txv     ${COLOR1}$yesterday_tx $yesterday_txv      ${COLOR1}$month_tx $month_txv\033[0m"           
  echo -e "\033[0;36m   └───────────────────────────────────────────┘\033[0m"
}

function Acces_Use_Command() {
  echo -e "\033[0;36m ───────────────────────────────────────────────── \033[0m"
  echo -e "\033[0;36m           \033[0;36m access use \033[1;33m type \033[0;36m menu command\033[0m"
  echo -e "\033[0;36m ───────────────────────────────────────────────── \033[0m"
}

paintechvpn
Service_System_Operating
Service_Status
List_All_Account
Details_Bw_Clients
Acces_Use_Command
