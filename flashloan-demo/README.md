# ⚠️ Flash Loan Exploit Demo (Solidity)

This project demonstrates a simplified flash loan exploit simulation using Solidity smart contracts in Remix. It simulates how an attacker can borrow ETH via a flash loan and retain part of the funds when the lender fails to verify repayment.

---

## 🧠 What is a Flash Loan?

A flash loan allows a user to borrow assets with **no collateral**, under the condition that the loan is **repaid within the same transaction**. If the repayment condition fails, the entire transaction reverts.

---

## 💣 Exploit Scenario

In this simulated exploit:
- A vulnerable lender issues a flash loan
- The attacker repays **only part of the loan**
- Due to missing checks, the lender accepts the partial repayment
- The attacker **keeps the rest as profit**

---

## 🧪 Contracts Overview

| Contract | Description |
|----------|-------------|
| `MockLendingProtocol.sol` | The vulnerable lender that provides flash loans **without checking full repayment** |
| `FlashLoanAttacker.sol`   | The attacker contract that receives the flash loan and **keeps part of it** |
| `IFlashLoanReceiver.sol`  | Interface used for callback |

---

## 🚀 How to Test in Remix

1. **Load all `.sol` files** into Remix IDE
2. **Compile all contracts**
3. Deploy `MockLendingProtocol` (set VALUE to `0`)
4. Fund the lender:
   - Set `VALUE` = `5 ether`
   - Click fallback `(transact)` on `MockLendingProtocol`
5. Deploy `FlashLoanAttacker`
   - Input deployed lender address
   - Set VALUE to `0`
6. Call:

