#! /bin/bash

sudo apt update
sudo apt install -y curl
sudo apt install -y docker.io
sudo apt install -y docker-compose 
sudo apt install -y golang-go

mkdir -p ~/go/work/src/github.com/hyberledger
echo 'export GOPATH=~/go/work' >> ~/.profile
source ~/.profile
cd ~/go/work/src/github.com/hyberledger
git clone https://github.com/hyperledger/fabric-samples

cd fabric-samples
sudo ./scripts/bootstrap.sh

mkdir -p chaincode/diamonds/
cp ~/chaincode-diamonds/chaincode/diamonds.go chaincode/diamonds/
