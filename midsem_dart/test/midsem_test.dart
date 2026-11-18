// =============================================================================
// A6 (5 marks) — Write at least 8 tests of your own. Run with: dart test
//
// Your tests must include, at minimum:
//   - a boundary test for ticketCategory (e.g. 11 and 12)
//   - a test that ticketCategory throws an ArgumentError
//   - a test for ticketPrice with isMember: true AND quantity >= 5 (use closeTo)
//   - a test that parseQuantity throws a FormatException
//   - a test that totalRevenue returns 0 for an empty list
// Use group() to organise your tests.
// =============================================================================
import 'package:test/test.dart';
import 'package:midsem_dart/midsem.dart';
import 'package:midsem_dart/tickets.dart';
import 'package:midsem_dart/event_wallet.dart';

void main() {
  group('ticketCategory()', () {
    test('30 is Adult', () {
      expect(ticketCategory(30), 'Adult');
    });
    test('11 is Child and 12 is Teen', () {
      expect(ticketCategory(11), 'Child');
      expect(ticketCategory(12), 'Teen');
    });
    test('120 is Senior', () {
      expect(ticketCategory(120), 'Senior');
    });
    test('negative age throws', () {
      expect(() => ticketCategory(-1), throwsArgumentError);
    });
  });

  group('ticketPrice()', () {
    test('member discount and five-ticket discount apply', () {
      expect(
        ticketPrice(category: 'Adult', quantity: 5, isMember: true),
        closeTo(106.875, 0.001),
      );
    });
    test('quantity below one throws', () {
      expect(() => ticketPrice(category: 'Adult', quantity: 0),
          throwsArgumentError);
    });
  });

  test('parseQuantity throws FormatException', () {
    expect(() => parseQuantity('abc'), throwsFormatException);
  });

  test('totalRevenue returns zero for empty list', () {
    expect(totalRevenue([]), 0);
  });

  test('countByCategory is empty for no sales', () {
    expect(countByCategory([]), isEmpty);
  });

  test('bigSpenders filters and sorts', () {
    expect(
        bigSpenders({'Kofi': 50, 'Ama': 120, 'Esi': 100}, 100), ['Ama', 'Esi']);
  });

  test('uniqueBuyers trims, lowercases, and removes duplicates', () {
    expect(uniqueBuyers(['Ama', ' ama', 'KOFI', '']), {'ama', 'kofi'});
  });

  group('Ticket management', () {
    test('VIP price includes each additional benefit', () {
      final ticket = VipTicket(
        id: 'VIP-1',
        holderName: 'Ama',
        additionalBenefits: ['Lounge', 'Meal'],
      );
      expect(ticket.price, 190.0);
    });

    test('ticket holder name is validated', () {
      expect(
        () => StandardTicket(id: 'S-1', holderName: '  '),
        throwsArgumentError,
      );
    });

    test('refund is counted once and excluded from sales', () {
      final standard = StandardTicket(id: 'S-1', holderName: 'Ama');
      final vip = VipTicket(id: 'V-1', holderName: 'Kofi');
      expect(standard.refund(), isTrue);
      expect(standard.refund(), isFalse);
      expect(totalSales([standard, vip]), 150.0);
      expect(vipCount([standard, vip]), 1);
    });
  });

  group('EventWallet', () {
    test('constructor rejects negative balance', () {
      expect(
        () => EventWallet(owner: 'Ama', initialBalance: -1),
        throwsArgumentError,
      );
    });

    test('exact balance payment is allowed', () {
      final wallet = EventWallet(owner: 'Ama', initialBalance: 200);
      wallet.pay(200);
      expect(wallet.balance, 0);
      expect(wallet.history, ['pay:200.0']);
    });

    test('cashback is applied as a percentage', () {
      final wallet = EventWallet(owner: 'Ama', initialBalance: 200);
      wallet.applyCashback(5);
      expect(wallet.balance, closeTo(210, 0.001));
    });
  });
}
