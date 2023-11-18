/** @type import('hardhat/config').HardhatUserConfig */

require('dotenv').config();
require("@nomiclabs/hardhat-ethers");

const { ALCHEMY_API_URL, ALCHEMY_API_KEY, METAMASK_PRIVATE_KEY } = process.env;

module.exports = {
  solidity: "0.8.19",
  defaultNetwork: "sepolia",
  networks: {
     hardhat: {},
     sepolia: {
        url: ALCHEMY_API_URL,
        accounts: [`0x${METAMASK_PRIVATE_KEY}`]
     }
  },
};
