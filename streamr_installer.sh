#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install wget git build-essential jq expect -y
. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/docker_installer.sh)
mkdir $HOME/.streamrDocker
expect <<END
	set timeout 300
	spawn docker run -it -v $(cd ~/.streamrDocker; pwd):/root/.streamr streamr/broker-node:testnet bin/config-wizard
	expect "Do you want to generate"
	send -- "\n"
	expect "Select the plugins"
	send -- "a\n"
	expect "Select a port for the websocket"
	send -- "\n"
	expect "Select a port for the mqtt"
	send -- "\n"
	expect "Select a port for the publishHttp"
	send -- "\n"
	expect "Select a path to store"
	send -- "\n"
	expect eof
END
docker run -it --restart=always --name=streamr_node -d -p 7170:7170 -p 7171:7171 -p 1883:1883 -v $(cd ~/.streamrDocker; pwd):/root/.streamr streamr/broker-node:testnet