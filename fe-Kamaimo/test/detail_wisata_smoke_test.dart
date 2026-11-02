import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:berani_kamaimo/features/user/detail_wisata/detail_wisata_screen.dart';
import 'package:berani_kamaimo/models/jarak_desa.dart';
import 'package:berani_kamaimo/models/ulasan.dart';

// ─── Fake loader data sesuai Figma "Detail Wisata - Luk Panenteng (Modern)" ───

JarakDesa _jarakLuwuk() => const JarakDesa(
      id: 1,
      desaId: 1,
      titikKota: 'LUWUK',
      jalur_darat: 'Perjalanan darat aspal pesisir menyusuri bukit karst '
          'dengan mobil rental atau ojek lokal Salakan langsung ke gapura danau.',
      jalur_laut: 'Berangkat dari Pelabuhan Rakyat Luwuk setiap pagi menuju '
          'Pelabuhan Salakan (Banggai Kepulauan) pukul 09:00 WITA.',
      jalur_udara: 'Penerbangan reguler terjadwal dari Makassar (UPG) atau '
          'Manado (MDC) menuju Bandara Luwuk (Wings Air / Batik Air).',
    );

Ulasan _ulasan() => const Ulasan(
      id: 1,
      nama: 'Rian Kusuma',
      rating: 5,
      komentar: 'Airnya benar-benar seperti kaca kristal tembus pandang!',
      createdAt: '2024-06-15',
    );

void main() {
  testWidgets('menampilkan hero + 4 section sesuai frame Figma Detail Wisata',
      (tester) async {
    tester.view.physicalSize = const Size(430, 4000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(MaterialApp(
      home: DetailWisataScreen(
        desaId: 1,
        namaDesa: 'Luk Panenteng',
        lokasi: 'Banggai Kepulauan, Sulawesi Tengah',
        foto: '',
        jarakLoader: () async => [_jarakLuwuk()],
        ulasanLoader: () async => [_ulasan()],
      ),
    ));
    await tester.pumpAndSettle();

    // Hero: pill status + tombol kembali + bagikan
    expect(
        find.text('Buka Hari Ini • 07:00 – 17:30 WITA'), findsOneWidget);

    // Section section pertama sesuai Figma (tanpa "TENTANG DESTINASI")
    expect(find.text('TENTANG DESTINASI'), findsNothing);

    // Section How to Get There: eyebrow + judul + segmented
    expect(find.text('AKSESIBILITAS & RUTE'), findsOneWidget);
    expect(find.text('Luk Panenteng'), findsOneWidget);
    expect(find.text('Dari Luwuk (Rute Tercepat)'), findsOneWidget);
    expect(find.text('Dari Palu (Ibukota)'), findsOneWidget);

    // Kartu rute default (Luwuk): 3 jalur (judul 2 baris sesuai Figma)
    expect(find.text('Kapal Cepat / Feri\nPenyeberangan'), findsOneWidget);
    expect(find.text('Salakan ke Luk Panenteng\nvia Liang'), findsOneWidget);
    expect(find.text('Bandara Syukuran\nAminuddin Amir (LUW)'), findsOneWidget);
    expect(find.text('JALUR LAUT'), findsOneWidget);
    expect(find.text('JALUR DARAT'), findsOneWidget);
    expect(find.text('JALUR UDARA'), findsOneWidget);

    // Section Fasilitas
    expect(find.text('KENYAMANAN BERKELANJUTAN'), findsOneWidget);
    expect(find.text('Fasilitas Desa Wisata'), findsOneWidget);
    expect(find.text('Sewa Kano Transparan'), findsOneWidget);
    expect(find.text('Homestay Kayu Pesisir'), findsOneWidget);
    expect(find.text('Pemandu Pokdarwis'), findsOneWidget);
    expect(find.text('Kuliner Ikan Bakar'), findsOneWidget);

    // Section Ulasan
    expect(find.text('TESTIMONI NYATA'), findsOneWidget);
    expect(find.text('Ulasan Pengunjung'), findsOneWidget);
    expect(find.text('Tulis Ulasan'), findsOneWidget);
    expect(find.text('Rian Kusuma'), findsOneWidget);
  });

  testWidgets('segmented Luwuk/Palu mengganti isi kartu rute', (tester) async {
    tester.view.physicalSize = const Size(430, 4000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(MaterialApp(
      home: DetailWisataScreen(
        desaId: 1,
        namaDesa: 'Luk Panenteng',
        lokasi: 'Banggai Kepulauan, Sulawesi Tengah',
        foto: '',
        jarakLoader: () async => [_jarakLuwuk()],
        ulasanLoader: () async => [_ulasan()],
      ),
    ));
    await tester.pumpAndSettle();

    // Default Luwuk: kartu laut ada
    expect(find.text('Kapal Cepat / Feri\nPenyeberangan'), findsOneWidget);
    // Belum ada data PALU → tap tab Palu memunculkan empty state
    await tester.tap(find.text('Dari Palu (Ibukota)'));
    await tester.pumpAndSettle();
    expect(find.text('Kapal Cepat / Feri\nPenyeberangan'), findsNothing);
    expect(find.textContaining('Rute dari Palu'), findsOneWidget);

    // Balik ke Luwuk: kartu muncul kembali
    await tester.tap(find.text('Dari Luwuk (Rute Tercepat)'));
    await tester.pumpAndSettle();
    expect(find.text('Kapal Cepat / Feri\nPenyeberangan'), findsOneWidget);
  });

  testWidgets('ulasan kosong memunculkan testimoni demo sesuai Figma',
      (tester) async {
    tester.view.physicalSize = const Size(430, 4000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(MaterialApp(
      home: DetailWisataScreen(
        desaId: 1,
        namaDesa: 'Luk Panenteng',
        lokasi: 'Banggai Kepulauan, Sulawesi Tengah',
        foto: '',
        jarakLoader: () async => [],
        ulasanLoader: () async => [],
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Tulis Ulasan'), findsOneWidget);
    // Fallback demo: 2 testimoni persis frame Figma
    expect(find.text('Rian Kusuma'), findsOneWidget);
    expect(find.text('Dinda Widyawati'), findsOneWidget);
    expect(find.text('Solo Traveler • Juni 2024'), findsOneWidget);
    expect(find.text('Keluarga • Mei 2024'), findsOneWidget);
    expect(find.textContaining('Belum ada ulasan'), findsNothing);
    // Ulasan asli kosong → jarak stub kosong → section rute disembunyikan
    expect(find.text('AKSESIBILITAS & RUTE'), findsNothing);
  });
}
