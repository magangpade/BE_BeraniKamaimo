import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:berani_kamaimo/core/providers/language_provider.dart';
import 'package:berani_kamaimo/features/user/eksplor/eksplor_screen.dart';
import 'package:berani_kamaimo/features/user/eksplor/eksplor_service.dart';

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

  test('mapper BE: hotel & kuliner diubah ke model UI', () {
    const hotelJson = {
      'nama_hotel': 'Hotel Uji',
      'wilayah': 'Palu',
      'lokasi': 'Jl. Uji',
      'tag': 'Tag Uji',
      'rating': '4.90',
      'rating_count': '12',
      'highlight': 'Highlight Uji',
      'harga_minimum': 100000,
      'harga_maximum': 200000,
      'jumlah_kamar': 10,
      'jumlah_tempatTidur': 4,
      'website': 'https://uji.id',
      'foto': 'assets/images/eksplor/hotel1.jpg',
    };
    final h = EksplorService.mapHotel(hotelJson);
    expect(h.nama, 'Hotel Uji');
    expect(h.rating, '4.9'); // 4.90 → 4.9
    expect(h.harga, 100000);
    expect(h.hargaCoret, 200000);
    expect(
      h.chips.map((c) => c.$2),
      containsAll(['10 Kamar', '4 Tempat Tidur']),
    );

    const kulinerJson = {
      'nama_makanan': 'Masakan Uji',
      'warung': 'Warung Uji',
      'wilayah': 'Palu',
      'tag': null,
      'deskripsi_id': 'Deskripsi uji.',
      'foto': 'assets/images/eksplor/kuliner1.jpg',
      'bahan': '🌿 Asam Jawa Muda, 🌶️ Cabai Rawit Hijau',
    };
    final k = EksplorService.mapKuliner(kulinerJson);
    expect(k.deskripsi, 'Deskripsi uji.');
    expect(k.bahan, hasLength(2));
    // Emoji dibuang → label murni teks
    expect(k.bahan[0].$2, 'Asam Jawa Muda');
    expect(k.bahan[1].$2, 'Cabai Rawit Hijau');
  });
}
