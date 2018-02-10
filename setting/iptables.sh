#!/bin/bash

#interface Name defined
LAN=eth0

LOCALNET_MASK=`ifconfig $LAN|sed -e 's/^.*Mask:\([^ ]*\)$/\1/p' -e d`

LOCALNET_ADDR=`netstat -rn|grep $LAN|grep $LOCALNET_MASK|cut -f1 -d' '`
LOCALNET=$LOCALNET_ADDR/$LOCALNET_MASK

/etc/rc.d/init.d/iptables stop

#Default ROOT defined
iptables -P INPUT DROP    
iptables -P OUTPUT ACCEPT 
iptables -P FORWARD DROP

iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -s $LOCALNET -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables -N LOG_PINGDEATH
iptables -A LOG_PINGDEATH -m limit --limit 1/s --limit-burst 4 -j ACCEPT
iptables -A LOG_PINGDEATH -j LOG --log-prefix '[IPTABLES PINGDEATH] : '
iptables -A LOG_PINGDEATH -j DROP
iptables -A INPUT -p icmp --icmp-type echo-request -j LOG_PINGDEATH

#iptables -A INPUT -p tcp --dport 20 -j ACCEPT
#iptables -A INPUT -p tcp --dport 21 -j ACCEPT
#iptables -A INPUT -p tcp --dport 22 -j ACCEPT 
iptables -A INPUT -p tcp --dport 10022 -j ACCEPT 
iptables -A INPUT -p tcp --dport 29418 -j ACCEPT 
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
#iptables -A INPUT -p tcp --dport 443 -j ACCEPT

#iptables -A INPUT -p tcp --dport 3000 -j ACCEPT

/etc/rc.d/init.d/iptables save
/etc/rc.d/init.d/iptables start
