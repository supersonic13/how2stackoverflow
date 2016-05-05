#!/bin/bash

#First check if docker is installed
DOCKER_INSTALLED=$(apt-cache policy docker-engine | grep 'Installed' | awk '{print $2}')
echo -e "\e[32mDocker installation status :"$DOCKER_INSTALLED
if [ "(none)" == "$DOCKER_INSTALLED" ] || [ "" == "$DOCKER_INSTALLED" ] ; then
	#echo "Docker installation not found ... Installing"
	echo -e "\e[32mDocker installation not found ... Installing  \e[39m"
	echo -e "\e[32mPerforiming an update .. \e[39m"
	sudo apt-get update
	sudo apt-get install -y apt-transport-https ca-certificates
	echo -e "\e[32mAdding GPG keys .. \e[39m"
	sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
	echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee /etc/apt/sources.list.d/docker.list
	sudo apt-get update
	echo -e "\e[32mPurging any old docker installation .. \e[39m"
	sudo apt-get purge -y lxc-docker
	echo -e "\e[32mChecking the cache policy for the installation .. \e[39m"
	sudo apt-cache policy docker-engine
	echo -e "\e[32mInstalling .. \e[39m"
	sudo apt-get install -y docker-engine
	echo -e "\e[32mStarting service .. \e[39m"
	sudo service docker start
fi

DOCKER_COMPOSE=$(which docker-compose)
if [ "" == "$DOCKER_COMPOSE" ]; then
	#Install docker compose
	echo -e "\e[32mInstalling docker-compose .. \e[39m"
	curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /tmp/docker-compose
	sudo chmod +x /tmp/docker-compose
	sudo mv /tmp/docker-compose /usr/local/bin/docker-compose
fi

echo -e "\e[32mInstallation complete .. \e[39m"
