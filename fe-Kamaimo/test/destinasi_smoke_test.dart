import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:berani_kamaimo/core/providers/language_provider.dart';
import 'package:berani_kamaimo/features/user/destinasi/destinasi_screen.dart';
import 'package:berani_kamaimo/features/user/home/user_shell.dart';

Widget _wrap(Widget child) => ChangeNotifierProvider<LanguageProvider>(
      create: (_) => LanguageProvider(),
      child: MaterialApp(home: child),
    );

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  // Self-check tab Destinasi: seed tampil, filter & kembali berfungsi.
  testWidgets('destinasi menampilkan seed & filter berfungsi', (tester) async {
    // Viewport tinggi supaya seluruh sliver tebangun (SliverList lazy)
    tester.view.physicalSize = const Size(430, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(_wrap(const DestinasiScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Destinasi Wisata'), findsOneWidget);
    expect(find.widgetWithText(GestureDetector, 'Semua'), findsWidgets);
    expect(find.text('Desa Wisata Bone Baru'), findsOneWidget);
    expect(find.text('Kawasan Kepulauan Togean'), findsOneWidget);

    // Filter Budaya → menampilkan Desa Wisata Pokekea; kembali Semua → kartu tampil lagi
    await tester.tap(find.text('Budaya'));
    await tester.pumpAndSettle();
    expect(find.text('Desa Wisata Pokekea'), findsOneWidget);
    await tester.tap(find.text('Semua'));
    await tester.pumpAndSettle();
    expect(find.text('Desa Wisata Bone Baru'), findsOneWidget);
  });

  // UserShell: nav tab Destinasi menampilkan layar destinasi
  testWidgets('nav ke tab Destinasi dari UserShell', (tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(_wrap(const UserShell()));
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
