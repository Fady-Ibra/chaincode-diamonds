#! /bin/bash


############################################################
################## Variables Configuration #################

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


############################################################
################ Before Running Transactions ###############

#1) Create a sample channel.
sudo docker exec \
	-e "CORE_PEER_LOCALMSPID=$MSP_ID" \
	-e "CORE_PEER_MSPCONFIGPATH=$MSP_CONFIG_PATH_PEER" \
	$ORG1_PEER \
		peer channel create \
			-o $ORDER_PEER:7050 \
			-c $CHANNEL_ID \
			-f $CONFIG_TX_FILE

#2) Add an existing peer to the channel.
sudo docker exec \
	-e "CORE_PEER_LOCALMSPID=$MSP_ID" \
	-e "CORE_PEER_MSPCONFIGPATH=$MSP_CONFIG_PATH_PEER" \
	$ORG1_PEER \
		peer channel join \
			-b $CHANNEL_ID.block

#3) Install the chaincode (its name is diamonds and its version is 1.0).
sudo docker exec \
	-e "CORE_PEER_LOCALMSPID=$MSP_ID" \
	-e "CORE_PEER_MSPCONFIGPATH=$MSP_CONFIG_PATH_CLI" \
	$CLI_PEER \
		peer chaincode install \
			-n diamonds \
			-v 1.0 \
			-p "github.com/diamonds" \
			-l "golang"

# 4) Instantiate the chaincode to initialize it on the channel mychannel. 
sudo docker exec \
	-e "CORE_PEER_LOCALMSPID=$MSP_ID" \
	-e "CORE_PEER_MSPCONFIGPATH=$MSP_CONFIG_PATH_CLI" \
	$CLI_PEER \
		peer chaincode instantiate \
			-o $ORDER_PEER:7050 \
			-C $CHANNEL_ID \
			-n diamonds \
			-l "golang" \
			-v 1.0 \
			-c '{"Args":[""]}' \
			-P "OR ('$MSP_ID.member')" #need enhance
