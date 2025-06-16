// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title SafeBank - Reentrancy-protected deposit and withdraw
/// @notice Demonstrates a secure pattern to prevent reentrancy vulnerabilities
contract SafeBank {
    // Mapping to track each user's ETH balance
    mapping(address => uint256) public balances;

    /// @notice Deposit ETH into the contract
    /// @dev Increases sender's balance based on msg.value
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    /// @notice Withdraw a specific amount of ETH
    /// @param amount The amount to withdraw (in wei)
    /// @dev State is updated before the external call to prevent reentrancy
    function withdraw(uint256 amount) public {
        // Ensure the user has enough balance
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // ✅ Update the internal state BEFORE interacting with external contract
        balances[msg.sender] -= amount;

        // Transfer ETH using a low-level call
        // This could trigger a fallback function in recipient contract
        (bool sent, ) = msg.sender.call{value: amount}("");

        // Check if transfer succeeded
        require(sent, "Transfer failed");
    }

    /// @notice View your balance in the contract
    /// @return The current ETH balance of the caller
    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}
