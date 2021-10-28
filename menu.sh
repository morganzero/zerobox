#!/bin/bash

menu=""
until [ "$menu" = "10" ]; do

clear

echo "
╔═════════════════════════════════════════════════════════════╗
║  ╔═══════════════════════════════════════════════════════╗  ║
║  ║                                                       ║  ║
║  ║            ███████╗███████╗██████╗  ██████╗           ║  ║
║  ║            ╚══███╔╝██╔════╝██╔══██╗██╔═══██╗          ║  ║
║  ║              ███╔╝ █████╗  ██████╔╝██║   ██║          ║  ║
║  ║             ███╔╝  ██╔══╝  ██╔══██╗██║   ██║          ║  ║
║  ║            ███████╗███████╗██║  ██║╚██████╔╝          ║  ║
║  ║            ╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝           ║  ║
║  ║                                                       ║  ║
║  ╚═══════════════════════════════════════════════════════╝  ║
╚═════════════════════════════════════════════════════════════╝"
cat << EOF

[1]  Redeploy Portainer
[2]  Redeploy Cloudcmd
[3]  Redeploy Autoheal
[4]  Redeploy Watchtower
[5]  Redeploy Caddy
═══════════════════════════════════════════════════════════════
[6]  Redeploy Deluge
[7]  Redeploy Radarr
[8]  Redeploy Sonarr
[9]  Redeploy Jackett
[10] Redeploy Prowlarr
═══════════════════════════════════════════════════════════════

[X] Exit

═══════════════════════════════════════════════════════════════

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

x)

;;

X)

;;

*) ;;

esac
done
