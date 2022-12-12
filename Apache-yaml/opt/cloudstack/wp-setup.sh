#!/bin/bash

# WordPress Salts
for i in `seq 1 8`
do
    wp_salt=$(</dev/urandom tr -dc 'a-zA-Z0-9!@#$%^&*()\-_ []{}<>~`+=,.;:/?|' | head -c 64 | sed -e 's/[\/&]/\\&/g')
    sed -e "0,/put your unique phrase here/s/put your unique phrase here/${wp_salt}/" \
        -i /var/www/html/wp-config.php;
done

#Cleanup script
rm -rf /usr/local/src/
mkdir -p /usr/local/src/
rm -rf /var/lib/cloud/instances/*
rm -rf /var/lib/cloud/data/*
find /var/log -mtime -1 -type f -exec truncate -s 0 {} \;
rm -rf /var/log/*.gz /var/log/*.[0-9] /var/log/*-????????
cat /dev/null > /var/log/lastlog; cat /dev/null > /var/log/wtmp
> /root/.ssh/authorized_keys
apt-get -y autoremove
apt-get -y autoclean
history -c
cat /dev/null > /root/.bash_history
unset HISTFILE

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
sed -i "s/\$domain/$dom/g"  /etc/apache2/sites-enabled/001-default.conf
a2enconf block-xmlrpc >/dev/null 2>&1
systemctl restart apache2
rm -rf /root/.bashrc
cp /etc/skel/.bashrc /root
