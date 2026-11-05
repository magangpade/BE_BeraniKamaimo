import 'package:berani_kamaimo/features/user/event/widgets/event_countdown_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> show(WidgetTester tester, EventCountdownCard card) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: card)));
    await tester.pump();
  }

  testWidgets('countdown mengikuti status sebelum, saat, dan sesudah event', (
    tester,
  ) async {
    final now = DateTime.now();

    await show(
      tester,
      EventCountdownCard(
        start: DateTime(now.year, now.month, now.day).add(
          const Duration(days: 2),
        ),
      ),
    );
    expect(find.text('Segera Hadir'), findsOneWidget);
    expect(find.text('MENUJU HARI EVENT'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());

    await show(
      tester,
      EventCountdownCard(
        start: now.subtract(const Duration(days: 1)),
        end: now.add(const Duration(days: 1)),
      ),
    );
    expect(find.text('Sedang Berlangsung'), findsOneWidget);
    expect(find.text('EVENT SEDANG BERLANGSUNG'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());

    await show(
      tester,
      EventCountdownCard(
        start: now.subtract(const Duration(days: 3)),
        end: now.subtract(const Duration(days: 1)),
      ),
    );
    expect(find.text('Telah Selesai'), findsOneWidget);
    expect(find.text('EVENT TELAH SELESAI'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });
}
