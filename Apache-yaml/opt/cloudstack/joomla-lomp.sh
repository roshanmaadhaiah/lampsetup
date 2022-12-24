#!/bin/bash

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
virtualhost $dom {
vhRoot /var/www/html/
configFile /usr/local/lsws/conf/vhosts/joomla/vhconf.conf
allowSymbolLink 1
enableScript 1
restrained 1
setUIDMode 0
}

listener $dom {
address *:80
secure 0
map $dom *, $dom, www.$dom
}

listener $dom$ssli {
address *:443
secure 1
keyFile /usr/local/lsws/conf/example.key
certFile /usr/local/lsws/conf/example.crt
map $dom *, $dom, www.$dom
}" | tee -a /usr/local/lsws/conf/httpd_config.conf >/dev/null

#Adding Virtual host Entry
echo "
docRoot                   /var/www/html

index  {
  useServer               0
  indexFiles              index.php index.html
}" | tee -a /usr/local/lsws/conf/vhosts/joomla/vhconf.conf >/dev/null

systemctl restart lsws
rm -rf /root/.bashrc
cp /etc/skel/.bashrc /root
