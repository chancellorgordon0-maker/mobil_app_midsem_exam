// =============================================================================
// INFT 425 / INPT 328 — Mid-Semester Practical Examination
// B3 — Debug exercise (8 marks)
//
// This class has FOUR bugs. Test it against the specification below,
// find each bug, make the SMALLEST fix, and document every bug in DEBUG.md
// (Symptom / Root cause / Fix / Verified).
//
// SPECIFICATION
//   1. A wallet can never be created with a negative initial balance
//      (throw ArgumentError).
//   2. topUp(amount): amount must be greater than 0 (throw ArgumentError).
//   3. pay(amount): amount must be greater than 0 (throw ArgumentError).
//      Paying EXACTLY the balance is allowed and leaves 0.00.
//      Paying more than the balance throws a StateError.
//   4. applyCashback(percent): adds percent% of the current balance.
//      applyCashback(5) on a balance of 200.00 gives 210.00.
//   5. history records each successful operation, in order.
// =============================================================================

class EventWallet {
  final String owner;
  double _balance;
  final List<String> _history = [];

  EventWallet({required this.owner, required double initialBalance})
      : _balance = initialBalance {
    if (initialBalance < 0) {
      throw ArgumentError('Initial balance cannot be negative');
    }
  }

  double get balance => _balance;
  List<String> get history => List.unmodifiable(_history);

  void topUp(double amount) {
    if (amount <= 0) {
      throw ArgumentError('Amount must be positive');
    }
    _balance += amount;
    _history.add('topUp:$amount');
  }

  void pay(double amount) {
    if (amount <= 0) {
      throw ArgumentError('Amount must be positive');
    }
    if (amount > _balance) {
      throw StateError('Insufficient funds');
    }
    _balance -= amount;
    _history.add('pay:$amount');
  }

  void applyCashback(int percent) {
    _balance += _balance * percent / 100;
    _history.add('cashback:$percent%');
  }

  @override
  String toString() =>
      'EventWallet($owner, GHS ${_balance.toStringAsFixed(2)})';
}
