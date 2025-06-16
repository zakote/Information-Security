// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// A simple and insecure price oracle contract.
// This oracle allows anyone to change the price — which is a vulnerability.
contract SimpleOracle {
    uint256 public price = 1 ether; // Initial fake price: 1 token = 1 ETH

    // Allows anyone to set a new price — this is the exploit vector.
    function setPrice(uint256 _price) external {
        price = _price;
    }

    // Used by other contracts to fetch the current price.
    function getPrice() external view returns (uint256) {
        return price;
    }
}
