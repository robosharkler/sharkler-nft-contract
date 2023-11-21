require('dotenv').config();
const hre = require("hardhat");
const METAMASK_WALLET_ADDRESS =  process.env.METAMASK_WALLET_ADDRESS;


async function main() {
    const SharklerNft = await hre.ethers.getContractFactory("SharklerNft");
    const sharklerNft = await SharklerNft.deploy(METAMASK_WALLET_ADDRESS);
    await sharklerNft.deployed();
    console.log("Contract deployed to address:", sharklerNft.address);
 }
 
main()
 .then(() => process.exit(0))
 .catch((error) => {
   console.error(error);
   process.exit(1);
 });