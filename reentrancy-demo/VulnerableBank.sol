// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VulnerableBank {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient funds");

        // Send ETH before updating balance — vulnerable!
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Transfer failed");

        balances[msg.sender] -= amount;
    }

    // Check balance
    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    // Contract balance
    function bankBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
