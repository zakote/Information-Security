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
6. Call: startAttack(1000000000000000000)
→ This triggers a flash loan of 1 ETH
7. Call `getPoolBalance()` and `getAttackerBalance()`

---

## ✅ Expected Result

- `MockLendingProtocol` balance: **4.5 ETH**
- `FlashLoanAttacker` balance: **0.5 ETH**

🎉 This simulates a real-world exploit where the attacker walks away with profit!

🔁 Explanation of Each Step
Attacker calls startAttack(1 ETH)
→ Asks lender for a flash loan.

Lender sends 1 ETH to attacker
→ Calls execute() function in attack contract.

Attacker receives 1 ETH in execute()
→ Keeps 0.5 ETH, repays only 0.5 ETH.

Lender doesn't check repayment
→ Accepts partial payment without reverting.

Attacker now has profit (0.5 ETH)
→ Exploit succeeds.
---

## 📤 Logs

Look for the `ProfitMade` event in the Remix terminal:

```bash
event ProfitMade(uint256 amount)
> ProfitMade: 500000000000000000

call
[call]from: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4to: FlashLoanAttacker.getAttackerBalance()data: 0xa8e...30e2c
from	0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
to	FlashLoanAttacker.getAttackerBalance() 0xB57ee0797C3fc0205714a577c02F7205bB89dF30
execution cost	378 gas (Cost only applies when called by a contract)
input	0xa8e...30e2c
output	0x00000000000000000000000000000000000000000000000006f05b59d3b20000
decoded input	{}
decoded output	{
	"0": "uint256: 500000000000000000"
}
logs	[]
raw logs	[]

call to MockLendingProtocol.getPoolBalance
call
[call]from: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4to: MockLendingProtocol.getPoolBalance()data: 0xabd...70aa2
from	0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
to	MockLendingProtocol.getPoolBalance() 0xEc29164D68c4992cEdd1D386118A47143fdcF142
execution cost	334 gas (Cost only applies when called by a contract)
input	0xabd...70aa2
output	0x0000000000000000000000000000000000000000000000003e73362871420000
decoded input	{}
decoded output	{
	"0": "uint256: 4500000000000000000"
}
logs	[]
raw logs	[]


