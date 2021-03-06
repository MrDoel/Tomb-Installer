#!/bin/bash
####################################
# TOMB INSTALLER                   #
#      							               #
# Coded by Mr.Doel                 #
# Contact me : doel@mc-crew.or.id  #
####################################

#   _____         .__                          _________        ___.                  _________                        
#  /     \ _____  |  | _____    ____    ____   \_   ___ \___.__.\_ |__   ___________  \_   ___ \_______   ______  _  __
# /  \ /  \\__  \ |  | \__  \  /    \  / ___\  /    \  \<   |  | | __ \_/ __ \_  __ \ /    \  \/\_  __ \_/ __ \ \/ \/ /
#/    Y    \/ __ \|  |__/ __ \|   |  \/ /_/  > \     \___\___  | | \_\ \  ___/|  | \/ \     \____|  | \/\  ___/\     / 
#\____|__  (____  /____(____  /___|  /\___  /   \______  / ____| |___  /\___  >__|     \______  /|__|    \___  >\/\_/  
#        \/     \/          \/     \//_____/           \/\/          \/     \/                \/             \/        


#importkl
lwh='\e[1;37m'
wh='\E[0;37m'
lrd='\e[1;31m'
rd='\E[0;31m'
cyn='\E[0;36m'
lcyn='\e[1;36m'
ylw='\E[0;33m'
lylw='\E[1;33m'
grn='\e[0;32m'
lgrn='\E[1;32m'
fin='\033[0m'

function chkwget {
    if [ -x "/usr/bin/wget" ]; then
		cmd=doel
	else
		echo -e ${lrd}"\nUnable to find download manager(wget) " ${fin};sleep 1;echo -e "Installing wget. . "; apt-get install wget;echo && echo -e ${grn}"Wget Ok. ."${fin};sleep 1
	fi
}



function chkroot {
echo && echo -e "Please wait . ."
echo && echo -e "${lwh}Checking Root user . . .${fin}";sleep 1
  if [[ $(id -u) = 0 ]]; then
  echo && echo -e ${grn}"Root user Ok. ."${fin};
  else
    echo && echo -e "${lrd}You must run this tool as Root${fin}";sleep 1
    echo && echo -e "exiting . .";sleep 2
    exit
  fi
}

function chkinet {
    echo && echo -e "${lwh}Checking internet connection . . .${fin}";
    
    WGET="/usr/bin/wget"

$WGET -q --tries=10 --timeout=5 http://www.google.com -O /tmp/index.google &> /dev/null
if [ ! -s /tmp/index.google ];then
    echo && echo -e "${rd}No internet connection! ${fin}"
    echo && echo -e "exiting . .";sleep 2
    exit
else
    echo && echo -e "${grn}Internet Connection Ok . . ${fin}";
    sleep 1
fi
}    

function head {
    clear
    echo -e " ${lrd}
               --------------------------------
               ||       TOMB INSTALLER       ||
               ||      	                     ||
               ||                            ||
               ||     Malang Cyber Crew      ||
               ||                            ||
               ||     Coded by : Mr.Doel     ||
               ||     http://mc-crew.or.id   ||
               --------------------------------${fin}"
}

function already {
	if [ -x "/usr/local/bin/tomb" ]; then
		echo -e "${grn}Tomb already installed${fin}";exit
	fi	
}

function install {
  head
  echo && echo -e "${grn}Installing . .${fin}"
  xterm -e sudo apt-get -y install zsh
  xterm -e sudo apt-get -y install gnupg
  xterm -e sudo apt-get -y install cryptsetup
  xterm -e sudo apt-get -y install pinentry-curses
  xterm -e wget -c https://github.com/dyne/Tomb/archive/master.zip
  mv master.zip Tomb.zip
  mv Tomb.zip /opt
  cd /opt
  xterm -e unzip Tomb.zip
  rm -r Tomb.zip
  cd Tomb-master
  xterm -e make install
  if [ -x "/usr/local/bin/tomb" ]; then
echo -e ${grn}"Installation Complete!\n"${fin}
echo -e "${ylw}To access Tomb, you can type tomb on terminal\nExample : \n${lrd}root@mcc:~# tomb -h${fin}"
echo
cd /opt
rm -rf Tomb-master
else 
echo -e ${rd}"Installation failed!\n\nPlease check your internet connection"${fin};sleep 1
fi
}
already
chkroot
chkinetn
chkwget
install
