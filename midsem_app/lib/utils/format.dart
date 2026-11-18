// =============================================================================
// C2 — formatPrice
// Return the price as text with two decimal places: 25.0 → 'GHS 25.00'
// =============================================================================

String formatPrice(double price) {
  return 'GHS ${price.toStringAsFixed(2)}';
}
