#! /bin/bash

apt update

apt-get install git  apt-transport-https ca-certificates  curl  gnupg-agent software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"

apt update

apt-get install docker-ce docker-ce-cli containerd.io docker-compose -y

systemctl enable docker.service

curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s https://hub-mirror.c.163.com

systemctl restart docker.service
