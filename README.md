# Chaincode Diamonds

In this repo, we 
1) install **Hyperledger Fabric** on Ubuntu machine, and
2) deploy **GoLang Chaincode** for a diamonds **Blockchain App** on the **Hyperledger Fabric**. 

This work is based on **Hyperledger Fabric Chaincode** course from https://developer.ibm.com/.

---

To install and deploy, we have to run these commands.
```
sudo apt install -y git
cd ~
git clone https://github.com/fady-a-m-ibrahim/chaincode-diamonds
cd chaincode-diamonds/
bash 1_installFabric.sh
bash 2_deployChaincode.sh 
```

---
**Available Transactions**

1. To send a **create diamond transaction**, we have to run this command.
```
sudo bash txCreateDiamond.sh DIAMOND_NAME ORIGIN CARATS OWNER 
```

2. To send a **query diamond transaction**, we have to run this command.
```
sudo bash txQueryDiamond.sh DIAMOND_NAME
```

3. To send a **transfer diamond transaction**, we have to run this command.
```
sudo bash txTransferDiamond.sh DIAMOND_NAME NEW_OWNER
```

Where DIAMOND_NAME, ORIGIN, CARATS, OWNER, and NEW_OWNER can be any value we want.
