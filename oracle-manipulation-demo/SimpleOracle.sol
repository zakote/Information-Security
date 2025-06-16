// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Fake price feed that the attacker can manipulate
contract SimpleOracle {
    uint256 public price = 1 ether; // Initial price: 1 token = 1 ETH

    function setPrice(uint256 _price) external {
        price = _price;
    }

    function getPrice() external view returns (uint256) {
        return price;
    }
}
