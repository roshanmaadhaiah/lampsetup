#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

echo
echo -e "${RED}Django Credentials are stored under /root/${NC}"
echo
echo -e "${RED}Django postgresql_passwords${NC}"
echo
cat /root/.postgresql_passwords
echo
echo -e "${RED}Django shell_user_passwords${NC}"
echo
cat /root/.shell_user_passwords
echo
echo -e "${RED}Django adminpanel_passwords${NC}"
echo
cat /root/.adminpanel_passwords
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
