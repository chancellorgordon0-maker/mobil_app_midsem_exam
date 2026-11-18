// =============================================================================
// C3 (10 marks) — Event detail screen
// See the exam paper for the full specification.
// =============================================================================
import 'package:flutter/material.dart';

import '../models/event.dart';
import '../utils/format.dart';

class EventDetailScreen extends StatelessWidget {
  final CampusEvent event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'event-${event.id}',
              child: CircleAvatar(
                radius: 36,
                child: Text(event.initial, style: theme.textTheme.titleLarge),
              ),
            ),
            const SizedBox(height: 16),
            Text(event.title, style: theme.textTheme.headlineSmall),
            const SizedBox(height: 12),
            _DetailRow(icon: Icons.place, label: 'Venue', value: event.venue),
            _DetailRow(
              icon: Icons.calendar_month,
              label: 'Date',
              value: event.dateLabel,
            ),
            _DetailRow(
              icon: Icons.payments,
              label: 'Price',
              value: formatPrice(event.price),
            ),
            _DetailRow(
              icon: Icons.event_seat,
              label: 'Available seats',
              value: '${event.seatsLeft}',
            ),
            _DetailRow(
              icon: Icons.groups,
              label: 'Total capacity',
              value: '${event.capacity}',
            ),
            if (event.isSoldOut)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'SOLD OUT',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.error,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: event.isSoldOut
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Ticket reserved for ${event.title}'),
                        ),
                      );
                    },
              child: const Text('Buy Ticket'),
            ),
            const SizedBox(height: 16),
            Text(
              'Built by CHANCELLOR .E. GORDEN — Index 224EI02003702',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text('$label: $value', style: theme.textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
