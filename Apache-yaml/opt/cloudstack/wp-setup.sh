#!/bin/bash
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
sed -i "s/\$domain/$dom/g"  /etc/apache2/sites-enabled/001-default.conf
a2enconf block-xmlrpc
systemctl restart apache2
