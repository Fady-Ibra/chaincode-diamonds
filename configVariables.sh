#! /bin/bash

# Membership Service Providers ID
export MSP_ID=${MSP_ID:-Org1MSP} 

# Membership Service Providers Configuration Paths
export MSP_CONFIG_PATH_PEER=${MSP_CONFIG_PATH_PEER:-/etc/hyperledger/msp/users/Admin@org1.example.com/msp} 
export MSP_CONFIG_PATH_CLI=${MSP_CONFIG_PATH_CLI:-/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp} 

# Other Variables
export ORG1_PEER=${ORG1_PEER:-peer0.org1.example.com}
export ORDER_PEER=${ORDER_PEER:-orderer.example.com}
export CLI_PEER=${CLI_PEER:-cli}
export CHANNEL_ID=${CHANNEL_ID:-mychannel}
export CONFIG_TX_FILE=${CONFIG_TX_FILE:-/etc/hyperledger/configtx/channel.tx} 
