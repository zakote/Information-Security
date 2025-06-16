// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MockLendingProtocol.sol";

contract FlashLoanAttacker is FlashLoanReceiver {
    address payable public owner;
    MockLendingProtocol public lender;

    constructor(address _lender) {
        owner = payable(msg.sender);
        lender = MockLendingProtocol(_lender);
    }

    function startAttack(uint256 loanAmount) public {
        lender.provideFlashLoan(loanAmount, address(this));
    }

    // Called by lender with ETH
    function execute() public payable override {
        // 🧨 Simulate exploit — e.g., manipulating DEX price or oracle
        // For now, just send back loan (to avoid revert)
        payable(address(lender)).transfer(msg.value);

        // In a real exploit, the attacker might profit here
    }

    // Withdraw any leftover ETH
    function withdraw() public {
        require(msg.sender == owner, "Only owner");
        owner.transfer(address(this).balance);
    }

    receive() external payable {}
}
