// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleOracle.sol";

// A mock lending pool that relies on the SimpleOracle to calculate loan limits.
contract OracleLendingPool {
    SimpleOracle public oracle;
    mapping(address => uint256) public collateral;

    // Initialize with an oracle contract address
    constructor(address _oracle) {
        oracle = SimpleOracle(_oracle);
    }

    // Allows user to deposit ETH as fake "collateral"
    function depositCollateral() external payable {
        collateral[msg.sender] += msg.value;
    }

    // Allows borrowing based on current oracle price × collateral
    function borrow() external {
        // Get the (manipulatable) token price from the oracle
        uint256 tokenPrice = oracle.getPrice();

        // Calculate maximum amount the user can borrow
        uint256 maxBorrow = (collateral[msg.sender] * tokenPrice) / 1 ether;

        // Send the calculated amount to the borrower
        payable(msg.sender).transfer(maxBorrow);
    }

    // Accepts ETH sent directly to the contract
    receive() external payable {}

    // Helper to view the current ETH pool
    function getPoolBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
