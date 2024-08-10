import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
const { projectUrl, privateKey } = require("./secret.json");

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    localhost: {
      url: "http://127.0.0.1:8545",
    },
    amoy: {
      url: projectUrl,
      accounts: [privateKey],
    },
  },
};

export default config;
