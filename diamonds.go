package main

import (
	"encoding/json"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	"github.com/hyperledger/fabric/protos/peer"
)

// FabricChaincode :: an exported type
type FabricChaincode struct {
}

type diamond struct {
	ObjectType string `json:"docType"`
	Name       string `json:"name"`
	Origin     string `json:"origin"`
	Carats     string `json:"carats"`
	Owner      string `json:"owner"`
}

func main() {
	shim.Start(new(FabricChaincode)) //setup the communication between chaincode and the peer that deployed it.
}

// Init :: an exported method
func (t *FabricChaincode) Init(stub shim.ChaincodeStubInterface) peer.Response {
	return shim.Success(nil)
}

// Invoke :: an exported method
func (t *FabricChaincode) Invoke(stub shim.ChaincodeStubInterface) peer.Response {
	function, args := stub.GetFunctionAndParameters()
	if function == "createDiamond" {
		return t.createDiamond(stub, args)
	} else if function == "transferDiamond" {
		return t.transferDiamond(stub, args)
	} else if function == "queryDiamond" {
		return t.queryDiamond(stub, args)
	} else {
		return shim.Error("Received unknown function invocation")
	}
}

func (t *FabricChaincode) createDiamond(stub shim.ChaincodeStubInterface, args []string) peer.Response {
	diamondName := args[0]
	origin := args[1]
	carats := args[2]
	owner := args[3]

	objectType := "diamond"
	diamond := &diamond{objectType, diamondName, origin, carats, owner}
	diamondJSONasBytes, err := json.Marshal(diamond)
	if err != nil {
		return shim.Error(err.Error())
	}

	err = stub.PutState(diamondName, diamondJSONasBytes)
	if err != nil {
		return shim.Error(err.Error())
	}

	return shim.Success(nil)
}

func (t *FabricChaincode) queryDiamond(stub shim.ChaincodeStubInterface, args []string) peer.Response {
	diamondName := args[0]

	diamondAsBytes, err := stub.GetState(diamondName)
	if err != nil {
		return shim.Error("Failed to get state for this diamond")
	} else if diamondAsBytes == nil {
		return shim.Error("This diamond does not exist")
	} else {
		return shim.Success(diamondAsBytes)
	}
}

func (t *FabricChaincode) transferDiamond(stub shim.ChaincodeStubInterface, args []string) peer.Response {
	diamondName := args[0]
	newOwner := args[1]

	diamondAsBytes, err := stub.GetState(diamondName)
	diamondToTransfer := diamond{}
	err = json.Unmarshal(diamondAsBytes, &diamondToTransfer)
	if err != nil {
		return shim.Error(err.Error())
	}
	diamondToTransfer.Owner = newOwner

	diamondJSONasBytes, _ := json.Marshal(diamondToTransfer)
	err = stub.PutState(diamondName, diamondJSONasBytes)
	if err != nil {
		return shim.Error(err.Error())
	}

	return shim.Success(nil)
}
