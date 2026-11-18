// =============================================================================
// C2 (12 marks) and C4 (5 marks) — Event list screen
// See the exam paper for the full specification.
// =============================================================================
import 'package:flutter/material.dart';

import '../data/sample_events.dart';
import '../models/event.dart';
import '../utils/format.dart';
import 'event_detail_screen.dart';

class EventListScreen extends StatelessWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final events = sampleEvents;

    return Scaffold(
      appBar: AppBar(title: Text('Campus Events (${events.length})')),
      body: events.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.event_busy, size: 48),
                  SizedBox(height: 12),
                  Text('No events available'),
                ],
              ),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                final useTwoColumns = constraints.maxWidth >= 600;
                if (useTwoColumns) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1.8,
                        ),
                    itemCount: events.length,
                    itemBuilder: (context, index) =>
                        _EventTile(event: events[index]),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: events.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) =>
                      _EventTile(event: events[index]),
                );
              },
            ),
    );
  }
}

class _EventTile extends StatelessWidget {
  final CampusEvent event;

  const _EventTile({required this.event});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => EventDetailScreen(event: event)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'event-${event.id}',
                child: CircleAvatar(
                  child: Text(event.initial, style: textTheme.titleMedium),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      event.venue,
                      style: textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      event.dateLabel,
                      style: textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          formatPrice(event.price),
                          style: textTheme.labelLarge,
                        ),
                        const Spacer(),
                        if (event.isSoldOut)
                          Text(
                            'SOLD OUT',
                            style: textTheme.labelLarge?.copyWith(
                              color: Theme.of(context).colorScheme.error,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
