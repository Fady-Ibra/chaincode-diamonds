#! /bin/bash

##################################################
##################### Transactions ####################

# 1) Create a diamond.
sudo docker exec \
	-e "CORE_PEER_LOCALMSPID=$MSP_ID" \
	-e "CORE_PEER_MSPCONFIGPATH=$MSP_CONFIG_PATH_CLI" \
	$CLI_PEER \
		peer chaincode invoke \
			-o $ORDER_PEER:7050 \
			-C $CHANNEL_ID \
			-n diamonds \
			-c '{"Args":["createDiamond","Kohinoor","India","105","Albert"]}'

# 2) Query the diamond.
sudo docker exec \
	-e "CORE_PEER_LOCALMSPID=$MSP_ID" \
	-e "CORE_PEER_MSPCONFIGPATH=$MSP_CONFIG_PATH_CLI" \
	$CLI_PEER \
		peer chaincode query \
			-C $CHANNEL_ID \
			-n diamonds \
			-c '{"Args":["queryDiamond","Kohinoor"]}'

# 3) Transfer the diamond.
sudo docker exec \
	-e "CORE_PEER_LOCALMSPID=$MSP_ID" \
	-e "CORE_PEER_MSPCONFIGPATH=$MSP_CONFIG_PATH_CLI" \
	$CLI_PEER \
		peer chaincode invoke \
			-o $ORDER_PEER:7050 \
			-C $CHANNEL_ID \
			-n diamonds \
			-c '{"Args":["transferDiamond","Kohinoor","Victoria"]}'

# 4) Query the diamond.
sudo docker exec \
	-e "CORE_PEER_LOCALMSPID=$MSP_ID" \
	-e "CORE_PEER_MSPCONFIGPATH=$MSP_CONFIG_PATH_CLI" \
	$CLI_PEER \
		peer chaincode query \
			-C $CHANNEL_ID \
			-n diamonds \
			-c '{"Args":["queryDiamond","Kohinoor"]}'
