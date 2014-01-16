#!/bin/bash
#Seems obvious, isn't it ?
echo 'Enter your new password:'
passwd
#Package required:
echo 'Install a lot of packages'
apt-get install zsh curl git php5 php5-dev php5-mcrypt php5-intl php5-sqlite php5-mysql mysql-server python python3
chsh -s /bin/zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
sed -i "s/ZSH_THEME=robbyrussell/ZSH_THEME=candy/" .zshrc
