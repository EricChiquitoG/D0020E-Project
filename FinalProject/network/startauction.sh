# PRO SCRIPT FOR TESTING STUFF
#
# deploCC flags
# -c <channel name> - Name of channel to deploy chaincode to
# -ccn <name> - Chaincode name.
# -ccl <language> - Programming language of the chaincode to deploy: go, java, javascript, typescript
# -ccv <version>  - Chaincode version. 1.0 (default), v2, version3.x, etc
# -ccs <sequence>  - Chaincode definition sequence. Must be an integer, 1 (default), 2, 3, etc
# -ccp <path>  - File path to the chaincode.
# -ccep <policy>  - (Optional) Chaincode endorsement policy using signature policy syntax. The default policy requires an endorsement from Org1 and Org2
# -cccg <collection-config>  - (Optional) File path to private data collections configuration file
# -cci <fcn name>  - (Optional) Name of chaincode initialization function. When a function is provided, the execution of init will be requested and the function will be invoked
##


# Shutting down network if it's already up.
./network.sh down
# Starting network and a channel using ca, nameing channel mychannel
./network.sh up createChannel -c mychannel -ca
# Deploy chaincode to channel
./network.sh deployCC -ccn auction -ccp ../auction-simple/chaincode-go/ -ccl go -ccep "OR('Org1MSP.peer','Org2MSP.peer')"
# Go to applicationfolder to be able to install auction aplication
cd ../../fabric-samples/auction-simple/application-javascript

npm install
node enrollAdmin.js org1
node enrollAdmin.js org2
node registerEnrollUser.js org1 seller
node registerEnrollUser.js org1 bidder1
node registerEnrollUser.js org1 bidder2
node registerEnrollUser.js org2 bidder3
node registerEnrollUser.js org2 bidder4
node createAuction.js org1 seller PaintingAuction painting

