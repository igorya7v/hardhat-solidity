// SPDX-License-Identifier: MIT
pragma solidity 0.7.3;

import "hardhat/console.sol";

contract Demo {
  
  uint256 public x;
  uint256 public y;

  /// @dev delegate incrementX to the Incrementor contract below
  /// @param inc address to delegate increment call to
  function incrementX(address inc) external {
	inc.delegatecall(abi.encodeWithSignature("incrementX()"));
  }

  /// @dev delegate incrementY to the Incrementor contract below
  /// @param inc address to delegate increment call to
  function incrementY(address inc) external {
	inc.delegatecall(abi.encodeWithSignature("incrementY()"));
  }

  /// @dev determines if argument account is a contract or not
  /// @param account address to evaluate
  /// @return bool if account is contract or not
  function isContract(address account) external view returns (bool) {
	uint size;
	assembly { size := extcodesize(account) }
	return size > 0;
  }

  /// @dev converts address to uint256
  /// @param account address to convert
  /// @return uint256
  function addressToUint256(address account) external pure returns (uint256) {
	// address is 20 bytes (160 bits)
	return uint256(uint160(account));
  }

  /// @dev converts uint256 to address
  /// @param num uint256 number to convert
  /// @return address
  function uint256ToAddress(uint256 num) external pure returns (address) {
	return address(uint160(num));
  }

  /// @dev computes uniswapV2 pair address
  /// @param token0 address of first token in pair
  /// @param token1 address of second token in pair
  /// @return address of pair
  function getUniswapV2PairAddress(address token0, address token1)
    external
    pure
    returns (address)
  {
	// Mainnet UniswapV2Factory
	// https://etherscan.io/address/0x5c69bee701ef814a2b6a3edd4b1652cb9cc5aa6f
	address factoryAddress = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
	
	return pairFor(factoryAddress, token0, token1);
  }
  
  // returns sorted token addresses, 
  // used to handle return values from pairs sorted in this order
  function sortTokens(address tokenA, address tokenB) 
	internal 
	pure 
	returns (address token0, address token1) 
  {
      require(tokenA != tokenB, 'UniswapV2Library: IDENTICAL_ADDRESSES');
      (token0, token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
      require(token0 != address(0), 'UniswapV2Library: ZERO_ADDRESS');
  }

  // calculates the CREATE2 address for a pair without making any external calls
  function pairFor(address factory, address tokenA, address tokenB) 
	internal 
	pure 
	returns (address pair) 
  {
	(address token0, address token1) = sortTokens(tokenA, tokenB);
	pair = address(uint160(uint256(keccak256(abi.encodePacked(
		hex'ff',
        factory,
        keccak256(abi.encodePacked(token0, token1)),
        hex'96e8ac4277198ff8b6f785478aa9a39f403cb768dd02cbee326c3e7da348845f' // init code hash
	)))));
  }
}

contract Incrementor {
  uint256 public x;
  uint256 public y;

  function incrementX() external {
	x++;
  }

  function incrementY() external {
    y++;
  }
}