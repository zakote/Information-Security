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

## 🛡 Fix

Always update state *before* external calls, or use OpenZeppelin's `ReentrancyGuard`.
