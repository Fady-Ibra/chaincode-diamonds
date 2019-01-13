#! /bin/bash

. 0_configVariables.sh

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
			-P "OR ('$MSP_ID.member')" 
