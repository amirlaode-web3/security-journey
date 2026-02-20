# Week 1 Audit Observation

## 1. Vulnerability Studied
Reentrancy (Classic pattern)

## 2. Root Cause
External call executed before state update (Interaction before Effect).

## 3. Impact
Attacker can repeatedly call withdraw before balance is updated,
draining the entire contract balance.

## 4. Proof of Concept
Reproduced using:
- ReentrancyVault.sol (vulnerable)
- ReentrancyAttacker.sol
- Reentrancy.t.sol

Confirmed:
Vault drained successfully.

## 5. Mitigation
1. Apply Checks-Effects-Interactions pattern.
2. Use ReentrancyGuard (defense-in-depth).

## 6. Gas Comparison
- CEI withdraw: 34299 gas
- Guarded withdraw: 37017 gas
- Overhead: ~2718 gas

## 7. Personal Auditor Notes
- CEI prevents logic flaw.
- Guard prevents human mistake.
- Security vs Gas tradeoff must be evaluated case by case.
