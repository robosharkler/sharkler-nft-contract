async function main() {
    const SharklerNft = await ethers.getContractFactory("SharklerNft");
    const sharklerNft = await SharklerNft.deploy("Deploying SharklerNft smart contract......");
    console.log("Contract deployed to address:", sharklerNft.address);
 }
 
 main()
   .then(() => process.exit(0))
   .catch(error => {
     console.error(error);
     process.exit(1);
   });