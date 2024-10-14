#!/bin/bash
RED='\033[0;31m'
NC='\e[0m'
GREEN='\033[0;32m'
hijau="\033[96m"
CYN="\033[96m"
CY="\033[36m"
clear

ssh_service=$(/etc/init.d/ssh status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
openvpn_service="$(systemctl show openvpn.service --no-page)"
oovpn=$(echo "${openvpn_service}" | grep 'ActiveState=' | cut -f2 -d=)
dropbear_status=$(/etc/init.d/dropbear status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
haproxy_service=$(systemctl status haproxy | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
fail2ban_service=$(/etc/init.d/fail2ban status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
cron_service=$(systemctl  status cron | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
badvpn1=$(systemctl status udp-mini-1 | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
badvpn2=$(systemctl status udp-mini-2 | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
badvpn3=$(systemctl status udp-mini-3 | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
Iptables=$(systemctl status netfilter-persistent | grep active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g')
RClocal=$(systemctl status rc-local | grep active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g')
Autorebot=$(systemctl status rc-local | grep active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g')
UdpSSH=$(systemctl status udp-custom | grep active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g')

openssh=$( systemctl status ssh | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $openssh == "running" ]]; then
    status_openssh="${GREEN} Online$NC │$NC"
else
    status_openssh="${RED}Offline$NC │$NC "
fi

# // SSH Websocket Proxy
ssh_ws=$( systemctl status ws | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $ssh_ws == "running" ]]; then
    status_ws_epro="${GREEN} Online$NC │$NC"
else
    status_ws_epro="${RED}Offline$NC │$NC"
fi

# // Trojan Proxy
ss=$( systemctl status xray | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $ss == "running" ]]; then
    status_ss="${GREEN} Online$NC │$NC"
else
    status_ss="${RED}Offline$NC │$NC"
fi

# // NGINX
nginx=$( /etc/init.d/nginx status | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
    status_nginx="${GREEN} Online$NC │$NC"
else
    status_nginx="${RED}Offline$NC │$NC"
fi

# STATUS SERVICE IPTABLES
if [[ $Iptables == "exited" ]]; then
    status_galo="${GREEN} Online$NC │$NC"
else
    status_galo="${RED}Offline$NC │$NC"
fi

# STATUS SERVICE  SSH 
if [[ $ssh_service == "running" ]]; then 
   status_ssh="${GREEN} Online$NC │$NC"
else
   status_ssh="${RED}Offline$NC │$NC"
fi

# STATUS SERVICE OPENVPN
if [[ $oovpn == "active" ]]; then
  status_openvpn="${GREEN} Online$NC │$NC"
else
  status_openvpn="${RED}Offline$NC │$NC"
fi

# STATUS SERVICE DROPBEAR
if [[ $dropbear_status == "running" ]]; then 
   status_beruangjatuh="${GREEN} Online$NC │$NC"
else
   status_beruangjatuh="${RED}Offline$NC  │$NC ${NC}"
fi

# STATUS SERVICE HAPROXY
if [[ $haproxy_service == "running" ]]; then 
   status_haproxy="${GREEN} Online$NC │$NC"
else
   status_haproxy="${RED}Offline$NC │$NC"
fi

# STATUS SERVICE  FAIL2BAN 
if [[ $fail2ban_service == "running" ]]; then 
   status_fail2ban="${GREEN} Online$NC │$NC"
else
   status_fail2ban="${RED}Offline$NC │$NC"
fi

# STATUS SERVICE  CRONS 
if [[ $cron_service == "running" ]]; then 
   status_cron="${GREEN} Online$NC │$NC"
else
   status_cron="${RED}Offline$NC │$NC"
fi

# STATUS SERVICE  BADVPN 1
if [[ $badvpn1 == "running" ]]; then 
   status_udp1="${GREEN} Online$NC │$NC"
else
   status_udp1="${RED}Offline$NC │$NC"
fi

# STATUS SERVICE  BADVPN 2
if [[ $badvpn2 == "running" ]]; then 
   status_udp2="${GREEN} Online$NC │$NC"
else
   status_udp2="${RED}Offline$NC │$NC"
fi

# STATUS SERVICE  BADVPN 3
if [[ $badvpn3 == "running" ]]; then 
   status_udp3="${GREEN} Online$NC │$NC"
else
   status_udp3="${RED}Offline$NC │$NC"
fi

if [[ $RClocal == "exited" ]]; then
    status_galoo="${GREEN} Online$NC │$NC"
else
    status_galoo="${RED}Offline$NC │$NC"
fi

if [[ $Autorebot == "exited" ]]; then
    status_galooo="${GREEN} Online$NC │$NC"
else
    status_galooo="${RED}Offline$NC │$NC"
fi

# STATUS SERVICE  SSH UDP 
if [[ $UdpSSH == "running" ]]; then 
   status_udp="${GREEN} Online$NC │$NC"
else
   status_udp="${RED}Offline$NC │$NC"
fi

# // Running Function 
clear
echo ""
echo -e " ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e " \033[46m              SERVICE INFORMATION           $NC"
echo -e " ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e " ┌───────────────────────────────────────┐${NC}"
echo -e " │ ${CYN}Service SSH / TUN${NC}                 ${CY}=$NC $status_ssh"
echo -e " │ ${CYN}Service SSH UDP${NC}                   ${CY}=$NC $status_udp"
echo -e " │ ${CYN}Service OpenVPN SSL${NC}               ${CY}=$NC $status_openvpn"
echo -e " │ ${CYN}Service OpenVPN WS-SSL${NC}            ${CY}=$NC $status_openvpn"
echo -e " │ ${CYN}Service OpenVPN UDP${NC}               ${CY}=$NC $status_openvpn"
echo -e " │ ${CYN}Service OpenVPN TCP${NC}               ${CY}=$NC $status_openvpn"
echo -e " │ ${CYN}Service OHP SSH${NC}                   ${CY}=$NC $status_openvpn"
echo -e " │ ${CYN}Service OHP Dropbear${NC}              ${CY}=$NC $status_openvpn"
echo -e " │ ${CYN}Service OHP OpenVPN${NC}               ${CY}=$NC $status_openvpn"
echo -e " │ ${CYN}Service WS ePRO${NC}                   ${CY}=$NC $status_ws_epro"
echo -e " │ ${CYN}Service BadVPN 7100${NC}               ${CY}=$NC $status_udp1"
echo -e " │ ${CYN}Service BadVPN 7200${NC}               ${CY}=$NC $status_udp2"
echo -e " │ ${CYN}Service BadVPN 7300${NC}               ${CY}=$NC $status_udp3"
echo -e " │ ${CYN}Service Dropbear${NC}                  ${CY}=$NC $status_beruangjatuh"
echo -e " │ ${CYN}Service Haproxy${NC}                   ${CY}=$NC $status_haproxy"
echo -e " │ ${CYN}Service Crons${NC}                     ${CY}=$NC $status_cron"
echo -e " │ ${CYN}Service Nginx Webserver${NC}           ${CY}=$NC $status_nginx"
echo -e " │ ${CYN}Service Xray Vmess WS TLS${NC}         ${CY}=$NC $status_ss"
echo -e " │ ${CYN}Service Xray Vmess WS Non TLS${NC}     ${CY}=$NC $status_ss"
echo -e " │ ${CYN}Service Xray Vmess gRPC${NC}           ${CY}=$NC $status_ss"
echo -e " │ ${CYN}Service Xray Vless WS TLS${NC}         ${CY}=$NC $status_ss"
echo -e " │ ${CYN}Service Xray Vless WS Non TLS${NC}     ${CY}=$NC $status_ss"
echo -e " │ ${CYN}Service Xray Vless gRPC${NC}           ${CY}=$NC $status_ss"
echo -e " │ ${CYN}Service Xray Trojan WS${NC}            ${CY}=$NC $status_ss"
echo -e " │ ${CYN}Service Xray Trojan Non WS${NC}        ${CY}=$NC $status_ss"
echo -e " │ ${CYN}Service Xray Trojan gRPC${NC}          ${CY}=$NC $status_ss"
echo -e " │ ${CYN}Service Iptables${NC}                  ${CY}=$NC $status_galo"
echo -e " │ ${CYN}Service RClocal${NC}                   ${CY}=$NC $status_galoo"
echo -e " │ ${CYN}Service Autoreboot${NC}                ${CY}=$NC $status_galooo"
echo -e " └───────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "Press [ Enter ] to back menu"
menu
