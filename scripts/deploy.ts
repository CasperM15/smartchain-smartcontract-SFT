import { ethers } from "hardhat";

async function main() {
  // Define the base URL for the token metadata
  const baseUrl = "https://nyc3.digitaloceanspaces.com/smartchain-files/"; // Replace with your base URL
  const initialOwner = "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266";

  // Fetch the contract to deploy
  const SmartChain = await ethers.getContractFactory("SmartChainSFT");

  // Deploy the contract with the URI for the ERC1155 token metadata
  const smartChain = await SmartChain.deploy(baseUrl, initialOwner);

  // Wait for the deployment to be mined
  const deployedSmartChain = await smartChain.waitForDeployment();

  // The contract instance has an 'address' property
  console.log("SmartChain deployed to:", await deployedSmartChain.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
