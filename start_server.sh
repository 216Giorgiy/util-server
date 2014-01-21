#!/bin/bash
msg(){
  echo -e "\033[1;36m   [info] $1\033[0m"
}
qstn(){
  echo -en "\033[1;34m   [question] $1\033[0m"
}
#TODO: sed stuff + check all test !! (Too tired to work on it more for now)


#If needed, change the password:
qstn "Change password? [y/N]"; read CHANGE_PASS
test -z "$CHANGE_PASS" -o "$CHANGE_PASS" = "n" -o "$CHANGE_PASS" = "N" || passwd

#Package required:
msg 'Install a lot of packages'
apt-get update && apt-get upgrade
apt-get -q -y install zsh curl git python python-pip python-imaging python-jinja2 python-lxml python3 \
	libxml2-dev libxslt1-dev nmap mysql-server \
	php5 php5-dev php5-mcrypt php5-intl php5-sqlite php5-mysql php-pear

#Install oh-my-zsh:
msg 'Install oh-my-zsh with candy theme -we like candies-'
chsh -s /bin/zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
sed -i "s/ZSH_THEME=robbyrussell/ZSH_THEME=candy/" .zshrc

#If wanted, change ssh port:
qstn "Enter new ssh port -leave blank to keep it- > "; read PORT_SSH
test -z "$PORT_SSH" && msg "port unchanged"
test -z "$PORT_SSH" || (test $PORT_SSH -eq '0' && msg "cannot be equal to 0, kept unchanged")
test -z "$PORT_SSH" || (test $PORT_SSH -gt '0' && msg "switch to #$PORT_SSH " && echo '**TODO with sed**')

### above is OK ###

#If wanted, unauthorize root to ssh:
qstn "Should root shh? [y/N]"; read ROOT_SSH
test "$ROOT_SSH" -o "$ROOT_SSH" = "n" -o "$ROOT_SSH" = "N" || echo '**TODO with sed**'

#If wanted, create new user(s):
qstn "Create new user(s)? [n/Y]"; read NEW_USER
test "$NEW_USER" -o "$NEW_USER" = "n" -o "$NEW_USER" = "N" || ./useradd.sh

