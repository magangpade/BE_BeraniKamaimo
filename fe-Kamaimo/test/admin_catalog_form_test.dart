import 'package:berani_kamaimo/core/network/api_client.dart';
import 'package:berani_kamaimo/core/network/token_store.dart';
import 'package:berani_kamaimo/features/admin/crud/admin_entity_form_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  Future<Map<String, dynamic>> create(
    WidgetTester tester,
    String type,
    Map<String, String> fields,
  ) async {
    tester.view.physicalSize = const Size(900, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    Map<String, dynamic>? saved;
    final api = ApiClient(
      tokenStore: InMemoryTokenStore(),
      httpClient: MockClient((_) async => http.Response('{}', 200)),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: AdminEntityFormDialog(
              title: type,
              entityType: type,
              api: api,
              onSave: (body) async => saved = body,
            ),
          ),
        ),
      ),
    );
    for (final entry in fields.entries) {
      final input = find.byKey(Key('admin-field-${entry.key}'));
      await tester.ensureVisible(input);
      await tester.enterText(input, entry.value);
      await tester.pump();
    }
    await tester.ensureVisible(find.byKey(const Key('admin-save')));
    await tester.tap(find.byKey(const Key('admin-save')));
    await tester.pumpAndSettle();
    expect(saved, isNotNull);
    return saved!;
  }

  testWidgets('paket baru menyimpan wilayah, fasilitas, kontak, dan gambar', (
    tester,
  ) async {
    final saved = await create(tester, 'tourPackage', {
      'nama_wisata_id': 'Jelajah Poso',
      'lokasi_id': 'Tentena, Poso',
      'deskripsi_id': 'Paket menjelajahi Danau Poso.',
      'harga': '1200000',
      'kontak': '081234567890',
      'media': 'https://example.com/poso.jpg',
      'wilayah': 'Poso',
      'durasi': '2 Hari 1 Malam',
      'fasilitas': 'Transportasi, Hotel, Pemandu',
    });
    expect(saved['wilayah'], 'Poso');
    expect(saved['fasilitas'], 'Transportasi, Hotel, Pemandu');
    expect(saved['harga'], 1200000);
    expect(saved['media'], 'https://example.com/poso.jpg');
  });

  testWidgets('hotel baru menyimpan kontak, harga, dan titik Maps', (
    tester,
  ) async {
    final saved = await create(tester, 'hotel', {
      'nama_hotel': 'Penginapan Poso',
      'lokasi': 'Tentena, Poso',
      'telepon': '081234567890',
      'jumlah_kamar': '12',
      'jumlah_tempatTidur': '20',
      'harga_minimum': '350000',
      'link_gmaps': 'https://maps.google.com/?q=Tentena',
      'foto': 'https://example.com/hotel.jpg',
      'wilayah': 'Poso',
    });
    expect(saved['wilayah'], 'Poso');
    expect(saved['telepon'], '081234567890');
    expect(saved['harga_minimum'], 350000);
    expect(saved['link_gmaps'], 'https://maps.google.com/?q=Tentena');
  });

  testWidgets('kuliner baru menyimpan tempat, kontak, web, dan Maps', (
    tester,
  ) async {
    final saved = await create(tester, 'kuliner', {
      'nama_makanan': 'Kaledo Poso',
      'lokasi': 'Tentena, Poso',
      'deskripsi_id': 'Sajian khas Sulawesi Tengah.',
      'foto': 'https://example.com/kaledo.jpg',
      'wilayah': 'Poso',
      'warung': 'Warung Danau',
      'telepon': '081234567890',
      'website': 'warungdanau.id',
      'link_gmaps': 'https://maps.google.com/?q=Warung+Danau',
    });
    expect(saved['warung'], 'Warung Danau');
    expect(saved['telepon'], '081234567890');
    expect(saved['website'], 'warungdanau.id');
    expect(saved['link_gmaps'], 'https://maps.google.com/?q=Warung+Danau');
  });
}
