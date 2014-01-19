#!/bin/sh

clear

wget http://downloads.sourceforge.net/project/roundcubemail/roundcubemail/0.9.5/roundcubemail-0.9.5.tar.gz?r=http%3A%2F%2Froundcube.net%2Fdownload%2F&ts=1389863438&use_mirror=garr
mv roundcubemail-*.tar.gz /var/www/
tar xfz /var/www/roundcubemail-*.tar.gz
rm -f /var/www/roundcubemail-*.tar.gz
mv /var/www/roundcubemail-* /var/www/roundcubemail
chown -R root:root /var/www/roundcubemail
chown -R www-data:root /var/www/roundcubemail/temp/
chown -R www-data:root /var/www/roundcubemail/logs/

if [ -z "${mysql_roundcube_password}" ]; then
  tmp=$(</dev/urandom tr -dc A-Za-z0-9 | head -c12)
  read -p "MySQL roundcube user password [${tmp}]:" mysql_roundcube_password
  mysql_roundcube_password=${mysql_roundcube_password:-${tmp}}
  echo "MySQL roundcube: ${mysql_roundcube_password}" >> .passwords
fi

if [ -z "${mysql_root_password}" ]; then
  read -p "MySQL root password []:" mysql_root_password
fi

sed -e "s|mypassword|${mysql_roundcube_password}|" <<'EOF' | mysql -u root -p"${mysql_root_password}"
USE mysql;
CREATE USER 'roundcube'@'localhost' IDENTIFIED BY 'mypassword';
GRANT USAGE ON * . * TO 'roundcube'@'localhost' IDENTIFIED BY 'mypassword';
CREATE DATABASE IF NOT EXISTS `roundcube`;
GRANT ALL PRIVILEGES ON `roundcube` . * TO 'roundcube'@'localhost';
FLUSH PRIVILEGES;
EOF

mysql -u root -p"${mysql_root_password}" 'roundcube' < /var/www/roundcubemail/SQL/mysql.initial.sql

cp /var/www/roundcubemail/config/main.inc.php.dist /var/www/roundcubemail/config/main.inc.php

sed -i "s|^\(\$rcmail_config\['default_host'\] =\).*$|\1 \'localhost\';|" /var/www/roundcubemail/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['smtp_server'\] =\).*$|\1 \'localhost\';|" /var/www/roundcubemail/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['smtp_user'\] =\).*$|\1 \'%u\';|" /var/www/roundcubemail/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['smtp_pass'\] =\).*$|\1 \'%p\';|" /var/www/roundcubemail/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['support_url'\] =\).*$|\1 \'https://duckduckgo.com\';|" /var/www/roundcubemail/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['quota_zero_as_unlimited'\] =\).*$|\1 true;|" /var/www/roundcubemail/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['preview_pane'\] =\).*$|\1 true;|" /var/www/roundcubemail/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['read_when_deleted'\] =\).*$|\1 false;|" /var/www/roundcubemail/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['check_all_folders'\] =\).*$|\1 true;|" /var/www/roundcubemail/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['display_next'\] =\).*$|\1 true;|" /var/www/roundcubemail/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['top_posting'\] =\).*$|\1 true;|" /var/www/roundcubemail/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['sig_above'\] =\).*$|\1 true;|" /var/www/roundcubemail/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['login_lc'\] =\).*$|\1 2;|" /var/www/roundcubemail/config/main.inc.php

cp /var/www/roundcubemail/config/db.inc.php.dist /var/www/roundcubemail/config/db.inc.php

sed -i "s|^\(\$rcmail_config\['db_dsnw'\] =\).*$|\1 \'mysqli://roundcube:${mysql_roundcube_password}@localhost/roundcube\';|" /var/www/roundcubemail/config/db.inc.php

rm -rf /var/www/roundcubemail/installer

service apache2 restart
