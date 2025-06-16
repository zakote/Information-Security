// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Interface that flash loan receivers must implement.
// It defines a single function, `execute()`, that the lender will call after sending the loan.
interface IFlashLoanReceiver {
    function execute() external payable;
}
