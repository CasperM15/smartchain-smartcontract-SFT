import { ethers } from "hardhat";

async function main() {
  // Fetch the contract to deploy
  const SmartChain = await ethers.getContractFactory("SmartChainSFT");

  // Deploy the contract
  const smartChain = await SmartChain.deploy();

  // The contract instance is expected to have an 'address' property
  const contractAddress = (smartChain as any).target;

  console.log("SmartChain deployed to:", contractAddress);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
