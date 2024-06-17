import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
const { projectUrl, privateKey } = require("./secret.json");

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    amoy: {
      url: projectUrl,
      accounts: [privateKey],
    },
  },
};

export default config;
