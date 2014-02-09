#!/bin/bash

msg(){
  echo -e "\033[1;36m   [info] $1\033[0m"
}

# Installing java (eurk)
sudo apt-get install openjdk-7-jre
msg 'Java jre installed'

# Download and install subsonic
wget http://downloads.sourceforge.net/project/subsonic/subsonic/4.9/subsonic-4.9.deb\?r\=\&amp\;ts\=1391970102\&amp\;use_mirror\=cznic
mv subsonic-* subsonic.deb
dpkg -i subsonic.deb
msg 'Subsonic installed'

msg 'Listening on port 40'
