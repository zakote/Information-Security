# 🚨 Flash Loan Attack Demo (Simplified)

This demo shows how flash loans work in DeFi and how attackers can use them to manipulate protocol logic.

## 🧪 Components

- `MockLendingProtocol.sol`: Simulated lending pool that offers flash loans
- `FlashLoanAttacker.sol`: Contract that borrows ETH and could use it to exploit DEX/oracle

## 🧬 How to Test in Remix

1. Deploy `MockLendingProtocol`, fund it with ETH
2. Deploy `FlashLoanAttacker`, passing `MockLendingProtocol` address
3. Call `startAttack()` with e.g., 1 ETH
4. Observe the loan goes out and comes back in a single transaction

💡 In real exploits, attackers use the borrowed ETH to manipulate token prices or protocol state during `execute()`
