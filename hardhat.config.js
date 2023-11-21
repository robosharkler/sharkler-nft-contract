/** @type import('hardhat/config').HardhatUserConfig */

require('dotenv').config();
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");

const ALCHEMY_API_URL =  process.env.ALCHEMY_API_URL;
const METAMASK_PRIVATE_KEY = process.env.METAMASK_PRIVATE_KEY;
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY;

module.exports = {
  solidity: "0.8.20",
  paths: {
    artifacts: './src/artifacts',
  },
  defaultNetwork: "sepolia",
  networks: {
     hardhat: {},
     sepolia: {
        url: ALCHEMY_API_URL,
        accounts: [`0x${METAMASK_PRIVATE_KEY}`]
     },
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY
  },
};
