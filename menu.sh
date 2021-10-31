#!/bin/bash

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

start(){
menu=""
until [ "$menu" = "10" ]; do
clear
banner
cat << EOF
══════════════════════════════════
[1]  Install Apps
[2]  Remove Apps
[3]  Update ZERO
══════════════════════════════════
[X] Exit
══════════════════════════════════

EOF
read -p "Input Value | [Enter]  : " menu </dev/tty

case $menu in

1)
install_apps
;;

2)
remove_apps
;;

3)
update_zero
;;

x)
break
;;

X)
break
;;

*) ;;

esac
done
}

install_apps(){
  menu=""
  until [ "$menu" = "10" ]; do
  clear
  banner
cat << EOF

[1]  Redeploy Portainer
[2]  Redeploy Cloudcmd
[3]  Redeploy Autoheal
[4]  Redeploy Watchtower
[5]  Redeploy Caddy
══════════════════════════════════
[6]  Redeploy Deluge
[7]  Redeploy Radarr
[8]  Redeploy Sonarr
[9]  Redeploy Jackett
[10] Redeploy Prowlarr
[11] Redeploy qBittorrent
══════════════════════════════════
[X] Exit
══════════════════════════════════

EOF
read -p "Input Value | [Enter]  : " menu </dev/tty

case $menu in

1)
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" portainer down
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" up -d portainer
;;

2)
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" cloudcmd down
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" up -d cloudcmd
;;

3)
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" autoheal down
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" up -d autoheal
;;

4)
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" watchtower down
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" up -d watchtower
;;

5)
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" caddy down
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" up -d caddy
;;

6)
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" deluge down
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" up -d deluge
;;

7)
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" radarr down
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" up -d radarr
;;

8)
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" sonarr down
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" up -d sonarr
;;

9)
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" jackett down
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" up -d jackett
;;

10)
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" prowlarr down
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" up -d prowlarr
;;

11)
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" qbittorrent down
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" up -d qbittorrent
;;

x)
break
;;

X)
break
;;

*) ;;

esac
done
}

remove_apps(){
menu=""
until [ "$menu" = "10" ]; do
clear
banner
cat << EOF

[1]  Remove Portainer
[2]  Remove Cloudcmd
[3]  Remove Autoheal
[4]  Remove Watchtower
[5]  Remove Caddy
══════════════════════════════════
[6]  Remove Deluge
[7]  Remove Radarr
[8]  Remove Sonarr
[9]  Remove Jackett
[10] Remove Prowlarr
[11] Remove qBittorrent
══════════════════════════════════
[X] Exit
══════════════════════════════════

EOF
read -p "Input Value | [Enter]  : " menu </dev/tty

case $menu in

1)
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" portainer down
;;

2)
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" cloudcmd down
;;

3)
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" autoheal down
;;

4)
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" watchtower down
;;

5)
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" caddy down
;;

6)
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" deluge down
;;

7)
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" radarr down
;;

8)
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" sonarr down
;;

9)
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" jackett down
;;

10)
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" prowlarr down
;;

11)
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" qbittorrent down
;;

x)
break
;;

X)
break
;;

*) ;;

esac
done
}

update_zero(){
  clear
  banner
  echo "
  ══════════════════════════════════"
  mkdir -p "/opt/zerobackup"
  mv "/opt/zerobox/.env" "/opt/zerobackup"
  rm -rf "/opt/zerobackup"
  mkdir -p "/opt/zerobackup"
  git clone https://github.com/morganzero/zerobox.git "/opt/zerobox"
  cp "/opt/zerobackup/.env" "/opt/zerobox/"
}
start
