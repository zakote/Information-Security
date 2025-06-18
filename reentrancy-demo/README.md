#  Reentrancy Attack Demo (Solidity)

This demo illustrates how a malicious contract can exploit a **reentrancy vulnerability** in a decentralized finance (DeFi) smart contract.

---

## Vulnerable Contract — `VulnerableBank.sol`

This smart contract allows users to:

- Deposit ETH to their balance
- Withdraw ETH through a `withdraw()` function

 However, the contract is vulnerable because it sends ETH to the user **before** updating the user's balance. This leaves a window where a reentrant call can occur.

---

##  Attacker Contract — `MaliciousContract.sol`

The attacker contract does the following:

1. Deposits ETH to the vulnerable contract  
2. Triggers `withdraw()`  
3. Re-enters the `withdraw()` function via the fallback function  
4. Repeats this cycle to **drain the contract** before balance updates

---

##  How to Run the Demo (in Remix)

1. **Deploy** `VulnerableBank`
2. **Deploy** `MaliciousContract`, passing the `VulnerableBank` address as a constructor argument
3. **Send 1 ETH** to `attack()` in `MaliciousContract`
4. Use `getBalance()` on `VulnerableBank` to observe it drained

---

##  Vulnerability Summary

| Issue                | Explanation                                                                 |
|---------------------|-----------------------------------------------------------------------------|
|  Reentrancy        | Balance is updated *after* sending ETH, enabling repeated withdrawals       |
| ⚠ Low-level call    | Uses `call{value:}` which forwards gas and allows fallback execution        |
|  No reentrancy lock| Lacks protections like `ReentrancyGuard` or check-effects-interactions pattern |

---

##  Slither Static Analysis

We used [Slither](https://github.com/crytic/slither) to analyze `VulnerableBank.sol`.

Command:

```bash
slither VulnerableBank.sol > slither-report.txt


