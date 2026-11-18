# EventWallet Debug Report

## Defect 1: Negative initial balances were accepted
- **Symptom:** `EventWallet(owner: 'Ama', initialBalance: -50)` created a wallet with a negative balance.
- **Root cause:** The constructor assigned `_balance` directly and performed no validation.
- **Fix:** Added an `ArgumentError` check in the constructor for balances below zero.
- **Verified:** The constructor-negative test passes with `throwsArgumentError`.

## Defect 2: Invalid top-ups were added to the balance
- **Symptom:** Zero and negative top-ups changed the balance and were recorded as successful operations.
- **Root cause:** `topUp()` did not validate the amount.
- **Fix:** Added a positive-amount validation before changing `_balance` or history.
- **Verified:** Invalid top-up behavior is covered with a positive-amount `ArgumentError` check and successful operations remain in history.

## Defect 3: Payment rejected the exact balance
- **Symptom:** Paying exactly the available balance raised `StateError` instead of leaving zero.
- **Root cause:** The insufficient-funds check used `>=` rather than `>`.
- **Fix:** Changed the check to reject only payments greater than `_balance`, allowing exact-balance payments.
- **Verified:** The exact-balance wallet test leaves the balance at `0` and records `pay:200.0`.

## Defect 4: Cashback was treated as a multiplier instead of a percentage
- **Symptom:** `applyCashback(5)` with a balance of 200 produced an incorrect 1000-point increase instead of 210.
- **Root cause:** The implementation added `_balance * percent` without dividing by 100.
- **Fix:** Changed the calculation to `_balance += _balance * percent / 100`.
- **Verified:** The cashback test passes with a balance close to `210.0`.
