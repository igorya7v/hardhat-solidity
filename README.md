# Hardhat-Solidity Demo
A simple Solidity demo using Radhat and Alchemy.

## Content
  *  Delegate calls to another contract to update storage variables.
  *  Determine if an Ethereum account is a contract.
  *  Convert address to uint256.
  *  Convert uint256 to address.
  *  Compute UniswapV2 pair addresses.

## Instrunctions

### To compile run:
```
npx hardhat compile
```

### To run the unit tests:
```
npx hardhat test
```

### To deploy to Ropstein testnet via the Alchemy run the following command, it requires .env file with your Alchemy credentials to be present at the root of the project:
```
npx hardhat run scripts/deploy.js --network ropsten
```
