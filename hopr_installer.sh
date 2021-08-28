#!/bin/bash
sudo apt update
sudo apt install wget -y
. <(wget -qO - https://raw.githubusercontent.com/SecorD0/utils/main/logo.sh)
read -p $'\e[40m\e[92mEnter the node password:\e[0m ' hopr_password
sudo apt upgrade -y
sudo apt install wget git build-essential jq -y
. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/docker_installer.sh)
docker pull hopr/hoprd:matic
docker run -d -it --restart=always -v $HOME/.hoprd-db-matic:/app/db -e DEBUG=hopr* -p 9091:9091 -p 3000:3000 -p 8080:8080 --name=hopr_node hopr/hoprd:matic --password='h0pR-w1Lh0RN' --init --announce --identity /app/db/.hopr-identity --apiToken="h0pR-$hopr_password!" --admin --adminHost 0.0.0.0 --healthCheck --healthCheckHost 0.0.0.0
docker restart hopr_node
. <(wget -qO - https://raw.githubusercontent.com/SecorD0/utils/main/insert_variable.sh) "hopr_log" "docker logs hopr_node --follow --tail=100" true
. <(wget -qO - https://raw.githubusercontent.com/SecorD0/utils/main/logo.sh)
echo -e '\nThe node was \e[40m\e[92mstarted\e[0m.\n'
echo -e 'Remember to save this file:'
echo -e "\033[0;31m$HOME/.hoprd-db-matic/\e[0m\n"
echo -e '\tv \e[40m\e[92mUseful commands\e[0m v\n'
echo -e 'To view the node log: \e[40m\e[92mhopr_log\e[0m'
echo -e 'To view the list of all containers: \e[40m\e[92mdocker ps -a\e[0m'
echo -e 'To delete the node container:'
echo -e '\e[40m\e[92mdocker stop hopr_node\e[0m'
echo -e '\e[40m\e[92mdocker container rm hopr_node\e[0m'
echo -e 'To restart the node: \e[40m\e[92mdocker restart hopr_node\e[0m\n\n'
echo -e "Admin panel URL: \e[40m\e[92mhttp://$(wget -qO- eth0.me):3000/\e[0m"
echo -e "Admin panel password: \e[40m\e[92mh0pR-$hopr_password!\e[0m"