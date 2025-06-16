# ✅ Formal Verification Demo — SafeBank + Slither

This demo showcases a secure Solidity smart contract (`SafeBank.sol`) and the use of [Slither](https://github.com/crytic/slither) — a static analysis tool — to verify its safety against common vulnerabilities like **reentrancy**.

---

## 🧠 What This Demonstrates

- ✅ A reentrancy-protected smart contract
- ✅ Audit performed with Slither static analyzer
- ✅ Verification that no critical issues exist
- ✅ Secure coding best practices for DeFi

---

## 🔐 Contract: `SafeBank.sol`

A minimal contract that:
- Lets users deposit and withdraw ETH
- Tracks balances using a `mapping`
- Prevents reentrancy by updating state **before** calling external functions

```solidity
function withdraw(uint256 amount) public {
    require(balances[msg.sender] >= amount, "Insufficient balance");

    // ✅ Update balance first (reentrancy protection)
    balances[msg.sender] -= amount;

    // External ETH transfer
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent, "Transfer failed");
}

🧪 Slither Audit
We used the following command to analyze the contract:

slither SafeBank.sol --print human-summary > SafeBank-slither.txt
This generates a security report in human-readable form. It checks for:

Reentrancy

Insecure patterns

Unsafe calls

Low-level bugs

📄 Audit Results Summary
Key findings from SafeBank-slither.txt:

✅ No high or medium severity issues

✅ Only 2 informational findings (non-critical)

✅ Slither confirms use of safe coding patterns

✅ Contract contains only 3 functions, no complex logic

| Metric               | Value                    |
| -------------------- | ------------------------ |
| Contracts analyzed   | 1                        |
| Functions            | 3                        |
| Reentrancy risk      | ❌ No                     |
| Low-level call usage | ✅ Present, but safe      |
| Safe for mainnet?    | 👍 Reasonable confidence |
