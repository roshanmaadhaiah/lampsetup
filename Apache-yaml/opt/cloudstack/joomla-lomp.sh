#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

echo
echo -e "${RED}Use the Below Database Credentials to setup Joomla${NC}"
echo
cat /root/.joomla_database_details
echo

#To replace the Domain Name in the apache configuration
a=0
while [ $a -eq 0 ]
do
 read -p "Domain/Subdomain name: " dom
 if [ -z "$dom" ]
 then
  a=0
  echo "Please provide a valid domain or subdomain name to continue to press Ctrl+C to cancel"
 else
  a=1
fi
done

#Configuring new host
ssli=ssl
echo "
virtualhost joomla {
  vhRoot                  /var/www/html
  configFile              /usr/local/lsws/conf/vhosts/joomla/vhconf.conf
  allowSymbolLink         1
  enableScript            1
  restrained              0
  setUIDMode              2
}

listener joomla {
  address                 *:80
  secure                  0
  map                     joomla *, $dom, www.$dom
}

listener joomlassl {
  address                 *:443
  secure                  1
  keyFile /etc/letsencrypt/live/$dom/privkey.pem
  certFile /etc/letsencrypt/live/$dom/cert.pem
  map                     joomla *, $dom, www.$dom
}" | tee -a /usr/local/lsws/conf/httpd_config.conf >/dev/null

#Adding Virtual host Entry
echo "docRoot                   /var/www/html

index  {
  useServer               0
  indexFiles              index.php index.html
}

context /phpmyadmin/ {
  location                /var/www/phpmyadmin
  allowBrowse             1
  indexFiles              index.php

  accessControl  {
    allow                 *
  }

  rewrite  {
    enable                0
    inherit               0

  }
  addDefaultCharset       off

  phpIniOverride  {

  }
}

rewrite  {
  enable                  1
  autoLoadHtaccess        1
}" | tee -a /usr/local/lsws/conf/vhosts/joomla/vhconf.conf >/dev/null

sed -i 's/map                      Example \*/map joomla *, '$dom', www.'$dom'/g' /usr/local/lsws/conf/httpd_config.conf >/dev/null

systemctl restart lsws

chown www-data. /tmp/lshttpd/ -R

/usr/local/lsws/bin/lswsctrl fullrestart

rm -rf /root/.bashrc
cp /etc/skel/.bashrc /root
