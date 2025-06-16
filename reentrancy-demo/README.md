# 🔓 Reentrancy Attack Demo (Solidity)

This demo shows how a malicious smart contract can exploit a reentrancy vulnerability in a DeFi protocol.

## 🏦 Vulnerable Contract

`VulnerableBank.sol` allows deposits and withdrawals but sends ETH *before* updating the user's balance. This makes it vulnerable to reentrancy.

## 👾 Attacker Contract

`MaliciousContract.sol` deposits ETH, then repeatedly triggers the `withdraw()` function using a fallback, draining funds before the balance updates.

## 🧪 How to Use (in Remix)

1. Deploy `VulnerableBank`
2. Deploy `MaliciousContract` with the address of `VulnerableBank`
3. Send at least 1 ETH to `attack()` function
4. Watch how the vulnerable contract gets drained

## 🔍 Slither Static Analysis

We analyzed `VulnerableBank.sol` using [Slither](https://github.com/crytic/slither) and found:

- 🛑 **Reentrancy vulnerability** in `withdraw()` — external call made before state update
- ⚠️ **Low-level call** (`call{value:}`) used without safeguards
- ⚠️ **Solidity version ^0.8.0** contains known issues (recommended: ^0.8.20+)

📄 [View full Slither report](./slither-report.txt)


##  Fix

Always update state *before* external calls, or use OpenZeppelin's `ReentrancyGuard`.

## ✅ Secure Version: `SafeBank.sol`

To fix the vulnerability, we simply update the user’s balance before sending ETH. This removes the window of opportunity for a reentrant call.

```solidity
balances[msg.sender] -= amount;
(bool sent, ) = msg.sender.call{value: amount}("");

