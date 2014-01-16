#!/bin/bash
msg(){
  echo -e "\033[1;36m   [info] $1\033[0m"
}

#Seems obvious, isn't it ?
msg 'Enter your new root password'
passwd
#Package required:
msg 'Install a lot of packages'
apt-get -q -y install zsh curl git python python3 nmap \
	php5 php5-dev php5-mcrypt php5-intl php5-sqlite php5-mysql mysql-server
#Install oh-my-zsh:
msg 'Install oh-my-zsh with candy theme -we like candies-'
chsh -s /bin/zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
sed -i "s/ZSH_THEME=robbyrussell/ZSH_THEME=candy/" .zshrc
