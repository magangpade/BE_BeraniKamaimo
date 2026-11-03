import 'package:berani_kamaimo/features/user/paket/paket_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Tab Paket: hero, kartu carousel, dan filter kategori',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: PaketScreen()),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Paket Tur Wisata'), findsOneWidget);
    // Kartu pertama carousel (Togean) tampil.
    expect(find.text('Rp 2.850.000'), findsOneWidget);
    expect(find.text('4 Hari 3 Malam'), findsOneWidget);

    // Filter Trekking: hanya Saluopa yang tersisa.
    await tester.tap(find.text('Trekking'));
    await tester.pumpAndSettle();
    expect(find.text('Eksotisme Kepulauan Togean'), findsNothing);
    expect(find.text('Trekking Air Terjun Saluopa'), findsOneWidget);
    expect(find.text('Rp 250.000'), findsOneWidget);
  });

  testWidgets('Tab Paket: pencarian memfilter kartu', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: PaketScreen()),
    ));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'togean');
    await tester.pumpAndSettle();
    expect(find.text('Eksotisme Kepulauan Togean'), findsOneWidget);
    expect(find.text('Sombori Secret Paradise'), findsNothing);

    await tester.enterText(find.byType(TextField), 'zzz');
    await tester.pumpAndSettle();
    expect(find.text('Belum ada paket untuk filter ini'), findsOneWidget);
  });
}
