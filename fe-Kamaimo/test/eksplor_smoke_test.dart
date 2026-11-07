import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:berani_kamaimo/core/providers/language_provider.dart';
import 'package:berani_kamaimo/features/user/eksplor/eksplor_screen.dart';

Widget _wrap(Widget child) => ChangeNotifierProvider<LanguageProvider>(
      create: (_) => LanguageProvider(),
      child: MaterialApp(home: child),
    );

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('tab Eksplor: segmented mengganti katalog Menginap <-> Kuliner',
      (tester) async {
    tester.view.physicalSize = const Size(430, 4000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_wrap(const EksplorScreen()));
    await tester.pumpAndSettle();

    // Header + segmented selalu tampil
    expect(find.text('Katalog Wisata & Kuliner'), findsOneWidget);
    expect(find.text('KATALOG PILIHAN DINAS PARIWISATA'), findsOneWidget);
    expect(find.byKey(const Key('eksplorTabMenginap')), findsOneWidget);
    expect(find.byKey(const Key('eksplorTabKuliner')), findsOneWidget);

    // Default tab Tempat Menginap: kartu hotel + trust card
    expect(find.text('Hotel Santika Palu'), findsOneWidget);
    expect(find.text('Jaminan Harga Resmi Dinas Pariwisata'), findsOneWidget);
    expect(find.text('Mulai dari'), findsWidgets);
    // Kartu berikutnya ikut ter-render (peek) → tombol aksi bisa lebih dari 1
    expect(find.text('Telepon'), findsWidgets);
    expect(find.text('Maps'), findsWidgets);
    expect(find.text('Website'), findsWidgets);

    // Switch ke tab Kuliner: intro gastronomi + kartu kuliner
    await tester.tap(find.byKey(const Key('eksplorTabKuliner')));
    await tester.pumpAndSettle();

    expect(find.text('Kuliner Otentik Kaili & Pesisir'), findsOneWidget);
    expect(find.text('WARISAN GASTRONOMI SULTENG'), findsOneWidget);
    expect(find.text('Ayam Panggang Biromaru'), findsOneWidget);
    // Trust card hanya ada di tab hotel
    expect(find.text('Jaminan Harga Resmi Dinas Pariwisata'), findsNothing);

    // Balik ke tab hotel
    await tester.tap(find.byKey(const Key('eksplorTabMenginap')));
    await tester.pumpAndSettle();
    expect(find.text('Hotel Santika Palu'), findsOneWidget);
  });

  testWidgets('search memfilter kartu per tab aktif', (tester) async {
    tester.view.physicalSize = const Size(430, 4000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_wrap(const EksplorScreen()));
    await tester.pumpAndSettle();

    // Tab kuliner: cari "kaledo"
    await tester.tap(find.byKey(const Key('eksplorTabKuliner')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'kaledo');
    await tester.pumpAndSettle();

    expect(find.text('Kaledo (Kaki Lembu Donggala)'), findsOneWidget);
    expect(find.text('Ayam Panggang Biromaru'), findsNothing);

    // Query ngawur → pesan kosong
    await tester.enterText(find.byType(TextField), 'rendang padang');
    await tester.pumpAndSettle();
    expect(find.text('Belum ada katalog untuk pencarian ini'), findsOneWidget);

    // Bersihkan & switch tab hotel: cari "santika"
    await tester.enterText(find.byType(TextField), '');
    await tester.tap(find.byKey(const Key('eksplorTabMenginap')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'santika');
    await tester.pumpAndSettle();

    expect(find.text('Hotel Santika Palu'), findsOneWidget);
    expect(find.text('Rama Garden Hotel'), findsNothing);
  });
}
