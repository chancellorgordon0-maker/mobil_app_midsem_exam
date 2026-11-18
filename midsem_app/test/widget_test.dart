import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:midsem_app/main.dart';

void main() {
  testWidgets('list displays events and count in AppBar', (tester) async {
    await tester.pumpWidget(const MidsemApp());

    expect(find.text('Campus Events (6)'), findsOneWidget);
    expect(find.text('Tech Talk: Flutter in Production'), findsOneWidget);
  });

  testWidgets('tap opens event details', (tester) async {
    await tester.pumpWidget(const MidsemApp());

    await tester.tap(find.text('Gospel Night'));
    await tester.pumpAndSettle();

    expect(find.textContaining('University Chapel'), findsOneWidget);
    expect(find.text('Buy Ticket'), findsOneWidget);
    expect(find.textContaining('224EI02003702'), findsOneWidget);
  });

  testWidgets('sold-out event disables reservation', (tester) async {
    await tester.pumpWidget(const MidsemApp());

    await tester.tap(find.text('Inter-Hall Football Final'));
    await tester.pumpAndSettle();

    expect(find.text('SOLD OUT'), findsOneWidget);
    final button = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Buy Ticket'),
    );
    expect(button.onPressed, isNull);
  });

  testWidgets('buy ticket shows confirmation', (tester) async {
    await tester.pumpWidget(const MidsemApp());

    await tester.tap(find.text('Gospel Night'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Buy Ticket'));
    await tester.pump();

    expect(find.text('Ticket reserved for Gospel Night'), findsOneWidget);
  });

  testWidgets('width 600 or more uses two-column grid', (tester) async {
    await tester.binding.setSurfaceSize(const Size(700, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MidsemApp());

    expect(find.byType(GridView), findsOneWidget);
  });
}
