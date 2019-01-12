#! /bin/bash

sudo apt update
sudo apt install curl
sudo apt install docker.io
sudo apt install docker-compose 
sudo apt install golang-go

mkdir -p ~/go/work/src/github.com/hyberledger
echo 'export GOPATH=~/go/work' >> ~/.profile
source ~/.profile
cd ~/go/work/src/github.com/hyberledger
git clone https://github.com/hyperledger/fabric-samples.git

cd fabric-samples
sudo ./scripts/bootstrap.sh

mkdir -p chaincode/diamonds/
mv diamonds.go chaincode/diamonds/

cd basic-network/
sudo docker-compose up -d
