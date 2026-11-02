import 'package:berani_kamaimo/features/user/event/event_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Tab Event: section, featured, dan filter kategori tampil',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: EventScreen()),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Agenda mendatang'), findsOneWidget);
    expect(find.text('Festival Danau Poso ke-24'), findsOneWidget);

    // Filter UMKM: featured & event Budaya hilang, kartu UMKM tampil.
    await tester.tap(find.text('UMKM'));
    await tester.pumpAndSettle();
    expect(find.text('Festival Danau Poso ke-24'), findsNothing);
    expect(find.text('Pasar Kreatif Sulteng'), findsOneWidget);
    expect(find.text('Jelajah Megalitikum Lore'), findsNothing);
  });
}
