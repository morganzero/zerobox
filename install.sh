#!/bin/bash

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

set +e

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

echo "
╔═════════════════════════════════════════════════════════════╗
║   Grab a cup ☕          |   This is going to take a while  ║
╚═════════════════════════════════════════════════════════════╝"
sleep 2

echo "
╔═════════════════════════════════════════════════════════════╗
║   Updating System 🐧                                        ║
╚═════════════════════════════════════════════════════════════╝"
echo; spinner; echo
curl https://raw.githubusercontent.com/morganzero/autoupdate/main/autoupdate.sh | sudo bash 1>/dev/null 2>&1

echo "
╔═════════════════════════════════════════════════════════════╗
║   Installing Docker 🐳                                      ║
╚═════════════════════════════════════════════════════════════╝"
echo; spinner; echo
apt-get install -y docker-ce 1>/dev/null 2>&1

echo "
╔═════════════════════════════════════════════════════════════╗
║   Creating Docker Network 🐳                                ║
╚═════════════════════════════════════════════════════════════╝"
echo; spinner; echo
docker network create \
--driver=bridge \
--subnet=172.18.0.0/16 \
--ip-range=172.18.5.0/24 \
--gateway=172.18.0.1 \
--opt com.docker.network.bridge.host_binding_ipv4=0.0.0.0 \
--opt com.docker.network.bridge.name=zeroworks \
--opt com.docker.network.bridge.enable_icc=true \
--opt com.docker.network.driver.mtu=1500 \
zeroworks

echo "
╔═════════════════════════════════════════════════════════════╗
║   Installing Docker Compose 🐳                              ║
╚═════════════════════════════════════════════════════════════╝"
echo; spinner; echo
if test $(which docker-compose); then
    sudo apt-get remove docker-compose 1>/dev/null 2>&1
fi

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose 1>/dev/null 2>&1
sudo chmod +x /usr/local/bin/docker-compose 1>/dev/null 2>&1
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose 1>/dev/null 2>&1

echo "
╔═════════════════════════════════════════════════════════════╗
║   Downloading ⬇️                                             ║
╚═════════════════════════════════════════════════════════════╝"
echo; spinner; echo
mkdir -p "/opt/zerobox" 1>/dev/null 2>&1
git clone https://github.com/morganzero/zerobox.git "/opt/zerobox" 1>/dev/null 2>&1
chmod -R 775 "/opt/zerobox" && chown -R 1000:1000 "/opt/zerobox" 1>/dev/null 2>&1
cd "/opt/zerobox"

echo "
╔═════════════════════════════════════════════════════════════╗
║   Configuring .env 🤫                                       ║
╚═════════════════════════════════════════════════════════════╝"
cp "/opt/zerobox/example.env" "/opt/zerobox/.env"
echo
echo -e "What's your E-Mail Address?" && read  -p "   Email : " EMAIL
echo
echo -e "What's your Domain name?" && read  -p "   Domain : " DOMAIN
echo; spinner; echo
sed -e "s/EMAIL=.*/EMAIL=$EMAIL/g" -e "s/DOMAIN=.*/DOMAIN=$DOMAIN/g" -i "/opt/zerobox/.env"

echo "
╔═════════════════════════════════════════════════════════════╗
║   Installing RClone ☁️                                       ║
╚═════════════════════════════════════════════════════════════╝"
echo; spinner; echo
bash <(wget -qO- https://rclone.org/install.sh) | sudo bash 1>/dev/null 2>&1

echo "
╔═════════════════════════════════════════════════════════════╗
║   Creating Shortcuts ✂️                                      ║
╚═════════════════════════════════════════════════════════════╝"
echo; spinner; echo
sudo ln -snf "/opt/zerobox/menu.sh" "/usr/local/bin/zero" 1>/dev/null 2>&1
chmod +x "/opt/zerobox/menu.sh" 1>/dev/null 2>&1

echo "
╔═════════════════════════════════════════════════════════════╗
║   Deploying Zero Stack 🚀                                   ║
╚═════════════════════════════════════════════════════════════╝"
echo; spinner; echo
docker-compose --env-file "/opt/zerobox/.env" -f "/opt/zerobox/docker-compose.yml" up -d

echo "
╔═════════════════════════════════════════════════════════════╗
║   Done! 🎉                                                  ║
╚═════════════════════════════════════════════════════════════╝"
