util-server
===========

What's that ?
-------------

Some scripts too create a great server.
* start_server.sh : some importants packages, and a beautifull root shell
* useradd.sh      : add some users with their shell
* rouncubemail.sh : download roundcubemail project and enable web installer


What does it do ?
-----------------

The script aims to:
* Change root passwd
* Secure ssh connexion (changing port + ssh key authentication)
* Install some common package (<small>zsh curl git php5 php5-dev php5-mcrypt php5-intl php5-sqlite python python3 nmap nmap</smaller>)
* Add user(s) (and add them -or not- to the sudoers)
