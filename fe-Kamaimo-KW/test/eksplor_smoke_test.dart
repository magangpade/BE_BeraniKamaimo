import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:berani_kamaimo/features/user/eksplor/eksplor_screen.dart';

/// Smoke test Tab Eksplor (Katalog Wisata & Kuliner) — desain dari PNG export
/// user (Tempat Menginap / Kuliner Khas), dikerjakan 2026-10-29.
void main() {
  testWidgets('tab Eksplor: segmented mengganti katalog Menginap <-> Kuliner',
      (tester) async {
    tester.view.physicalSize = const Size(430, 4000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MaterialApp(home: EksplorScreen()));
    await tester.pumpAndSettle();

    // Header + segmented selalu tampil
    expect(find.text('Katalog Wisata & Kuliner'), findsOneWidget);
    expect(find.text('KATALOG PILIHAN DINAS PARIWISATA'), findsOneWidget);
    expect(find.byKey(const Key('eksplorTabMenginap')), findsOneWidget);
    expect(find.byKey(const Key('eksplorTabKuliner')), findsOneWidget);

    // Default tab Tempat Menginap: kartu hotel + trust card
    expect(find.text('Swiss–Belhotel Silae Palu'), findsOneWidget);
    expect(find.text('Jaminan Harga Resmi Dinas Pariwisata'), findsOneWidget);
    expect(find.text('Mulai dari'), findsWidgets);
    // Kartu berikutnya ikut ter-render (peek) → tombol aksi bisa lebih dari 1
    expect(find.text('Telepon'), findsWidgets);
    expect(find.text('Maps'), findsWidgets);
    expect(find.text('Website'), findsWidgets);

    // Switch ke tab Kuliner: intro gastronomi + kartu kuliner
    await tester.tap(find.byKey(const Key('eksplorTabKuliner')));
    await tester.pumpAndSettle();

    expect(find.text('Cita Rasa Otentik Bumi Tadulako'), findsOneWidget);
    expect(find.text('EKSPLORASI GASTRONOMI'), findsOneWidget);
    expect(find.text('Onyop (Kuah Asam Ikan Segar)'), findsOneWidget);
    // Trust card hanya ada di tab hotel
    expect(find.text('Jaminan Harga Resmi Dinas Pariwisata'), findsNothing);

    // Balik ke tab hotel
    await tester.tap(find.byKey(const Key('eksplorTabMenginap')));
    await tester.pumpAndSettle();
    expect(find.text('Swiss–Belhotel Silae Palu'), findsOneWidget);
  });

  testWidgets('search memfilter kartu per tab aktif', (tester) async {
    tester.view.physicalSize = const Size(430, 4000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MaterialApp(home: EksplorScreen()));
    await tester.pumpAndSettle();

    // Tab kuliner: cari "kaledo"
    await tester.tap(find.byKey(const Key('eksplorTabKuliner')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'kaledo');
    await tester.pumpAndSettle();

    expect(find.text('Kaledo (Kaki Lemboe Asli)'), findsOneWidget);
    expect(find.text('Onyop (Kuah Asam Ikan Segar)'), findsNothing);
    expect(find.text('Lalampa (Ketan Bakar Isi Tuna)'), findsNothing);

    // Query ngawur → pesan kosong
    await tester.enterText(find.byType(TextField), 'rendang padang');
    await tester.pumpAndSettle();
    expect(find.text('Belum ada katalog untuk pencarian ini'), findsOneWidget);

    // Bersihkan & switch tab hotel: cari "swiss"
    await tester.enterText(find.byType(TextField), '');
    await tester.tap(find.byKey(const Key('eksplorTabMenginap')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'swiss');
    await tester.pumpAndSettle();

    expect(find.text('Swiss–Belhotel Silae Palu'), findsOneWidget);
    expect(find.text('Bukabuka Island Resort'), findsNothing);
  });
}
