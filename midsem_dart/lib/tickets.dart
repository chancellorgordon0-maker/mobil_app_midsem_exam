// =============================================================================
// INFT 425 / INPT 328 — Mid-Semester Practical Examination
// Section B — Object-oriented Dart (B1 and B2)
//
// Write all classes for B1 and the functions for B2 in this file.
// Use EXACTLY the names given in the exam paper — they are tested.
// =============================================================================

mixin Refundable {
  bool isRefunded = false;

  bool refund() {
    if (isRefunded) {
      return false;
    }
    isRefunded = true;
    return true;
  }
}

abstract class Ticket with Refundable {
  final String id;
  final String holderName;
  final double price;
  final String description;

  Ticket({
    required this.id,
    required this.holderName,
    required this.price,
    required this.description,
  }) {
    if (id.trim().isEmpty) {
      throw ArgumentError('Ticket id cannot be empty');
    }
    if (holderName.trim().isEmpty) {
      throw ArgumentError('Holder name cannot be empty');
    }
  }
}

class StandardTicket extends Ticket {
  StandardTicket({
    required super.id,
    required super.holderName,
  }) : super(
          price: 100.0,
          description: 'Standard event ticket',
        );
}

class VipTicket extends Ticket {
  final List<String> additionalBenefits;

  VipTicket({
    required super.id,
    required super.holderName,
    List<String> additionalBenefits = const [],
  })  : additionalBenefits = List.unmodifiable(additionalBenefits),
        super(
          price: 150.0 + (20.0 * additionalBenefits.length),
          description: 'VIP event ticket',
        );
}

double totalSales(List<Ticket> tickets) {
  return tickets
      .where((ticket) => !ticket.isRefunded)
      .fold<double>(0.0, (total, ticket) => total + ticket.price);
}

int vipCount(List<Ticket> tickets) {
  return tickets.whereType<VipTicket>().length;
}
