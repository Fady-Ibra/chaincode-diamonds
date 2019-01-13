#! /bin/bash

. 0_configVariables.sh

# 1) Create a diamond.
sudo docker exec \
	-e "CORE_PEER_LOCALMSPID=$MSP_ID" \
	-e "CORE_PEER_MSPCONFIGPATH=$MSP_CONFIG_PATH_CLI" \
	$CLI_PEER \
		peer chaincode invoke \
			-o $ORDER_PEER:7050 \
			-C $CHANNEL_ID \
			-n diamonds \
			-c "{ \"Args\" : [\"createDiamond\", \"$1\", \"$2\", \"$3\", \"$4\"] }"
