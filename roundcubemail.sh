wget http://downloads.sourceforge.net/project/roundcubemail/roundcubemail/0.9.5/roundcubemail-0.9.5.tar.gz?r=http%3A%2F%2Froundcube.net%2Fdownload%2F&ts=1389863438&use_mirror=garr
mv roundcubemail-0.9.5.tar.gz /var/www/
tar xfz /var/www/roundcubemail-0.9.5.tar.gz
mv /var/www/roundcubemail-0.9.5 /var/www/roundcubemail
chown -R root:root /var/www/roundcubemail
chown -R www-data:root /var/www/roundcubemail/temp/
chown -R www-data:root /var/www/roundcubemail/logs/
