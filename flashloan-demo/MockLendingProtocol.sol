// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MockLendingProtocol {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function provideFlashLoan(uint256 amount, address borrower) public {
        uint256 balanceBefore = address(this).balance;

        // Call borrower's execute() function
        FlashLoanReceiver(borrower).execute{value: amount}();

        // Ensure loan was repaid
        require(address(this).balance >= balanceBefore, "Flash loan not repaid");
    }

    // Accept ETH
    receive() external payable {}
}

abstract contract FlashLoanReceiver {
    function execute() public virtual payable;
}
