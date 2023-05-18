const hre = require("hardhat");

async function main() {
  // Get tsmart contract
  const DegenGamingToken = await hre.ethers.getContractFactory("DegenGamingToken");

  // Deploy contract
  const degenGaming = await DegenGamingToken.deploy();
  await degenGaming.deployed();

  // Display contract address
  console.log(`Points token deployed to ${degenGaming.address}`);
}

// To use async/await everywhere and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
