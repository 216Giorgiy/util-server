#!/bin/bash
msg(){
  echo -e "\033[1;36m   [info] $1\033[0m"
}

#TODO: loop + ask for sudoer + read login instead of parameter !

echo 'Login user 1' $1
adduser $1
  chsh -s /bin/zsh $1
  curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
echo 'Login user 2:' $2
adduser $2

echo $1 ' ALL=(ALL:ALL) ALL' >> /etc/sudoers
echo $2 ' ALL=(ALL:ALL) ALL' >> /etc/sudoers
