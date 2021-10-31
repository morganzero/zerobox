#!/bin/bash

UNDERLINED="\e[4m"
XUNDERLINED="\e[24m"
G="\e[1;32m"
W="\e[0;39m"
BLINK="\e[5m"
XBLINK="\e[25m"
zeroversion=$(cat /opt/zerobox/var/zerobox.number)
zeroupdate=$(wget -O- -q https://raw.githubusercontent.com/SUSHIB0X/SUSHIB0X/master/var/zerobox.number)

################################################################################
banner(){
echo "
███████╗███████╗██████╗  ██████╗
╚══███╔╝██╔════╝██╔══██╗██╔═══██╗
  ███╔╝ █████╗  ██████╔╝██║   ██║
 ███╔╝  ██╔══╝  ██╔══██╗██║   ██║
███████╗███████╗██║  ██║╚██████╔╝
╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝
"
}

spinner ()
{
    bar=" ████████████████████████████████████████████████"
    barlength=${#bar}
    i=0
    while ((i < 100)); do
        n=$((i*barlength / 100))
        printf "\e[00;34m\r[%-${barlength}s]\e[00m" "${bar:0:n}"
        ((i += RANDOM%5+2))
        sleep 0.02
    done
}

spinner_box(){
	local pid=$1
	local delay=0.50
	local spinstr='/-\|'
	while ps a | awk '{print $1}' | grep -q "$pid"; do
		local temp=${spinstr#?}
		printf "\e[00;35m [%c]  \e[00m" "${spinstr}"
		local spinstr=${temp}${spinstr%"$temp"}
		sleep ${delay}
		printf "\\b\\b\\b\\b\\b\\b"
	done
	printf "    \\b\\b\\b\\b"
}

update_zero_dev(){
  backup="/opt/zeroBackup/zerobox/"
  now=$(date +'%Y-%m-%d-%H%M')
  lastbackup="$backup/zerobox-$now"
  clear
  sbx_banner
  echo -e "\e[34m══════════════════════════════════\\e[00m"
  echo -e "\e[35m[+]\e[00m  ZEROBOX IS UPDATING!"
  echo -e "\e[34m══════════════════════════════════\\e[00m"
  echo
  printf ":::  Backing up .env-file         : "; mkdir -p "$backup"; cp "/opt/zerobox/.env" "$backup/env.backup" &> /dev/null & spinner_box $!; echo -e "\e[93m [✓]\e[00m"
  printf ":::  Creating Backup              : "; mv "/opt/zerobox" "$lastbackup" &> /dev/null & spinner_box $!; echo -e "\e[93m [✓]\e[00m"
  printf ":::  Deleting 5-days old Backups  : "; /usr/bin/find "$backup" -mindepth 1 -type d -mtime +7 -exec rm -rf {} \; &> /dev/null & spinner_box $!; echo -e "\e[93m [✓]\e[00m"
  printf ":::  Downloding Latest Version    : "; git clone -b develop https://github.com/morganzero/zerobox.git "/opt/zerobox" &> /dev/null & spinner_box $!; echo -e "\e[93m [✓]\e[00m"
  printf ":::  Restoring Local Changes      : "; cp "$lastbackup/env.backup" "/opt/zerobox/.env" -L >> /dev/null 2>&1 &> /dev/null & spinner_box $!; echo -e "\e[93m [✓]\e[00m"
  printf ":::  Deleting Unnecessary Files   : "; /usr/bin/find "/opt/zerobox/" -type f -iname "*.md" -delete >> /dev/null 2>&1 && rm "/opt/zerobox/LICENSE" >> /dev/null 2>&1 &> /dev/null & spinner_box $!; echo -e "\e[93m [✓]\e[00m"
  printf ":::  Ensuring Dependencies are OK : "; sleep 0.5; &> /dev/null & spinner_box $!; echo -e "\e[93m [✓]\e[00m" #while read -r line; do apt-get -y install "$line"; done < /opt/zerobox/templates/dependencies >> /dev/null 2>&1 &> /dev/null & spinner_box $!; echo -e "\e[93m [✓]\e[00m"
  echo
}

create_shortcut(){
  ln -snf "/opt/sushibox/updatezero.sh" "/usr/bin/local/zeroupdate"
}

update_zero_dev
create_shortcut
