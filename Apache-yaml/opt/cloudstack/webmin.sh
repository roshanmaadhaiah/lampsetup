#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

echo
echo -e "${RED}To login to Webmin Admin Panel:- http://IPADDRESS:10000${NC}"
echo
echo -e "${RED}Webmin Credentials are stored under /root/.webmin_root_password${NC}"
echo
echo -e "${RED}Use the Below Webmin Credentials to login webmin Panel${NC}"
echo
cat /root/.webmin_root_password
echo

#Cleanup script
rm -rf /usr/local/src/
mkdir -p /usr/local/src/
rm -rf /var/lib/cloud/instances/*
rm -rf /var/lib/cloud/data/*
find /var/log -mtime -1 -type f -exec truncate -s 0 {} \; >/dev/null 2>&1
rm -rf /var/log/*.gz /var/log/*.[0-9] /var/log/*-????????
cat /dev/null > /var/log/lastlog; cat /dev/null > /var/log/wtmp
> /root/.ssh/authorized_keys
apt-get -y autoremove >/dev/null 2>&1
apt-get -y autoclean >/dev/null 2>&1
history -c
cat /dev/null > /root/.bash_history
unset HISTFILE

rm -rf /root/.bashrc
cp /etc/skel/.bashrc /root
