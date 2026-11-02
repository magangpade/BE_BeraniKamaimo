import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:berani_kamaimo/features/user/destinasi/destinasi_screen.dart';
import 'package:berani_kamaimo/features/user/home/user_shell.dart';

void main() {
  // Self-check tab Destinasi: seed tampil, filter & kembali berfungsi.
  testWidgets('destinasi menampilkan seed & filter berfungsi', (tester) async {
    // Viewport tinggi supaya seluruh sliver tebangun (SliverList lazy)
    tester.view.physicalSize = const Size(430, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const MaterialApp(home: DestinasiScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Destinasi Wisata'), findsOneWidget);
    expect(find.widgetWithText(GestureDetector, 'Semua'), findsWidgets);
    expect(find.text('Kepulauan Togean'), findsOneWidget);
    expect(find.text('Pulo Dua Balantak'), findsOneWidget);

    // Filter UMKM → kosong; kembali Semua → kartu tampil lagi
    await tester.tap(find.text('UMKM'));
    await tester.pumpAndSettle();
    expect(find.text('Kepulauan Togean'), findsNothing);
    await tester.tap(find.text('Semua'));
    await tester.pumpAndSettle();
    expect(find.text('Kepulauan Togean'), findsOneWidget);
  });

  // UserShell: nav tab Destinasi menampilkan layar destinasi
  testWidgets('nav ke tab Destinasi dari UserShell', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: UserShell()));
    await tester.pumpAndSettle();
    final navItem = find.descendant(
      of: find.byType(GestureDetector),
      matching: find.text('Destinasi'),
    );
    await tester.tap(navItem.last);
    await tester.pumpAndSettle();
    expect(find.text('Destinasi Wisata'), findsOneWidget);
  });
}
