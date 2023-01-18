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
