# Chaincode Diamonds

In this repo, we install Hyperledger Fabric on Ubuntu machine and then deploy GoLang Chaincode for a diamonds app on the Hyperledger Fabric. 
This work is based on Hyperledger Fabric Chaincode course from https://developer.ibm.com/

---

To start installing and deploying, we have to run these commands.
```
sudo apt install -y git
cd ~
git clone https://github.com/fady-a-m-ibrahim/chaincode-diamonds
cd chaincode-diamonds/
bash 1_installFabric.sh
bash 2_deployChaincode.sh 
```

---
Available Trasactions
===

1. To send a **create diamond trasaction**, we have to run this command.
```
sudo bash txCreateDiamond.sh
```

2. To send a **query diamond trasaction**, we have to run this command.
```
sudo bash txQueryDiamond.sh
```

3. To send a **transfer diamond trasaction**, we have to run this command.
```
sudo bash txTransferDiamond.sh
```
