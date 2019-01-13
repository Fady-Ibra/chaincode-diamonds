#! /bin/bash

. 0_configVariables.sh

# 2) Query the diamond.
sudo docker exec \
	-e "CORE_PEER_LOCALMSPID=$MSP_ID" \
	-e "CORE_PEER_MSPCONFIGPATH=$MSP_CONFIG_PATH_CLI" \
	$CLI_PEER \
		peer chaincode query \
			-C $CHANNEL_ID \
			-n diamonds \
			-c "{ \"Args\" : [\"queryDiamond\", \"$1\"] }"
			
