// =============================================================================
// INFT 425 / INPT 328 — Mid-Semester Practical Examination
// A5 (3 marks) — Section A report. Run with: dart run
// =============================================================================
import 'package:midsem_dart/midsem.dart';

void main() {
  print('=== SECTION A REPORT ===');

  const ages = [5, 15, 30, 65];
  final prices = <double>[];
  for (final age in ages) {
    final category = ticketCategory(age);
    final price = ticketPrice(category: category, quantity: 2);
    prices.add(price);
    print('Age $age → $category → 2 tickets: GHS ${price.toStringAsFixed(2)}');
  }

  print('Total revenue: GHS ${totalRevenue(prices).toStringAsFixed(2)}');

  try {
    parseQuantity('abc');
  } on FormatException catch (error) {
    print(error.message);
  } finally {
    print('Validation complete');
  }

  const sold = ['Adult', 'Child', 'Adult', 'Senior', 'Teen', 'Adult'];
  const spend = {'Ama': 120.0, 'Kofi': 45.5, 'Esi': 200.0, 'Yaw': 99.99};
  const buyers = ['Ama', ' ama', 'Kofi', 'KOFI ', 'Esi'];

  print('Tickets by category: ${countByCategory(sold)}');
  print('Big spenders: ${bigSpenders(spend, 100)}');
  print('Unique buyers: ${uniqueBuyers(buyers)}');
  print('========================================');
  print('Built by CHANCELLOR .E. GORDEN — Index 224EI02003702 — Variant 2');
  print('========================================');
}
