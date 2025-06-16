// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IFlashLoanReceiver.sol";

// A mock lending contract that simulates flash loan issuance.
// ⚠️ This version does NOT check whether the loan is repaid, which is intentionally insecure.
contract MockLendingProtocol {
    address public owner;

    // Constructor sets the contract deployer as the owner
    constructor() {
        owner = msg.sender;
    }

    // Provides a flash loan to a borrower.
    // Sends `amount` ETH and then calls back the borrower's `execute()` function.
    // ⚠️ Does NOT check if the loan is repaid — vulnerable!
    function provideFlashLoan(uint256 amount, address borrower) public {
        // Unsafe: no balance check after callback
        IFlashLoanReceiver(borrower).execute{value: amount}();
    }

    // Fallback receive function so the contract can accept ETH.
    receive() external payable {}

    // Utility to check how much ETH is currently in the lender's pool
    function getPoolBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
