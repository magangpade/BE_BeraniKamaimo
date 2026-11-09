import 'dart:convert';

import 'package:berani_kamaimo/core/network/api_client.dart';
import 'package:berani_kamaimo/core/network/token_store.dart';
import 'package:berani_kamaimo/features/admin/crud/crud_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:provider/provider.dart';

void main() {
  final cases =
      <
        ({
          String type,
          String title,
          String path,
          Map<String, dynamic> row,
          String field,
          String value,
        })
      >[
        (
          type: 'desaWisata',
          title: 'Desa Wisata',
          path: '/desaWisata',
          row: {
            'id': 1,
            'namaDesa_id': 'Desa lama',
            'lokasi_id': 'Poso',
            'deskripsi_id': 'Deskripsi desa',
            'latitude': -1.2,
            'longitude': 120.3,
          },
          field: 'namaDesa_id',
          value: 'Desa baru',
        ),
        (
          type: 'jarakDesa',
          title: 'Jalur Desa',
          path: '/jarak',
          row: {
            'id': 2,
            'desaId': 1,
            'titikKota': 'PALU',
            'jalur_darat': 'Jalur lama',
            'jalur_laut': '',
            'jalur_udara': '',
          },
          field: 'jalur_darat',
          value: 'Jalur baru',
        ),
        (
          type: 'atraksi',
          title: 'Atraksi & Event',
          path: '/atraksi',
          row: {
            'id': 3,
            'nameEvent': 'Event lama',
            'location_id': 'Palu',
            'description_id': 'Deskripsi',
            'startdate': '2026-10-24T00:00:00.000Z',
            'enddate': '2026-10-25T00:00:00.000Z',
          },
          field: 'nameEvent',
          value: 'Event baru',
        ),
        (
          type: 'tourPackage',
          title: 'Paket Wisata',
          path: '/tourPackage',
          row: {
            'id': 4,
            'nama_wisata_id': 'Paket lama',
            'lokasi_id': 'Tentena',
            'deskripsi_id': 'Deskripsi',
            'harga': 100000,
            'kontak': '628123456789',
          },
          field: 'nama_wisata_id',
          value: 'Paket baru',
        ),
        (
          type: 'kuliner',
          title: 'Kuliner',
          path: '/kuliner',
          row: {
            'id': 5,
            'nama_makanan': 'Makanan lama',
            'lokasi': 'Palu',
            'deskripsi_id': 'Deskripsi',
          },
          field: 'nama_makanan',
          value: 'Makanan baru',
        ),
        (
          type: 'rumahMakan',
          title: 'Rumah Makan',
          path: '/rumahMakan',
          row: {
            'id': 6,
            'resto': 'Resto lama',
            'kulinerId': 5,
            'link_gmaps': 'https://maps.google.com/old',
          },
          field: 'resto',
          value: 'Resto baru',
        ),
        (
          type: 'hotel',
          title: 'Hotel',
          path: '/hotel',
          row: {
            'id': 7,
            'nama_hotel': 'Hotel lama',
            'lokasi': 'Palu',
            'harga_minimum': 100000,
          },
          field: 'nama_hotel',
          value: 'Hotel baru',
        ),
        (
          type: 'ulasan',
          title: 'Ulasan Pengunjung',
          path: '/ulasan',
          row: {
            'id': 8,
            'nama': 'Pengulas lama',
            'rating': 4,
            'komentar': 'Komentar',
            'desaId': 1,
          },
          field: 'nama',
          value: 'Pengulas baru',
        ),
      ];

  for (final testCase in cases) {
    testWidgets('edit ${testCase.type} mengirim PATCH dan memuat ulang', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1100, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final row = Map<String, dynamic>.from(testCase.row);
      final calls = <String>[];
      final client = MockClient((request) async {
        calls.add('${request.method} ${request.url.path}');
        expect(request.headers['authorization'], 'Bearer test-token');
        if (request.method == 'PATCH') {
          expect(request.url.path, '/api${testCase.path}/${row['id']}');
          final body = jsonDecode(request.body) as Map<String, dynamic>;
          expect(body, {testCase.field: testCase.value});
          row.addAll(body);
          return http.Response(jsonEncode({'success': true, 'data': row}), 200);
        }
        expect(request.url.path, '/api${testCase.path}');
        return http.Response(
          jsonEncode({
            'success': true,
            'data': [row],
          }),
          200,
        );
      });
      final token = InMemoryTokenStore();
      await token.saveToken('test-token');
      await tester.pumpWidget(
        Provider<ApiClient>.value(
          value: ApiClient(httpClient: client, tokenStore: token),
          child: MaterialApp(
            home: Scaffold(
              body: CrudScreen(
                title: testCase.title,
                entityType: testCase.type,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('admin-edit-${row['id']}')));
      await tester.pumpAndSettle();
      final field = find.byKey(Key('admin-field-${testCase.field}'));
      await tester.ensureVisible(field);
      await tester.enterText(field, testCase.value);
      await tester.tap(find.byKey(const Key('admin-save')));
      await tester.pumpAndSettle();
      expect(calls, [
        'GET /api${testCase.path}',
        'PATCH /api${testCase.path}/${row['id']}',
        'GET /api${testCase.path}',
      ]);
      expect(find.text(testCase.value), findsWidgets);
      client.close();
    });
  }

  testWidgets('rumah makan dapat ditambah lalu dihapus lewat API', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1100, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final rows = <Map<String, dynamic>>[];
    final calls = <String>[];
    final client = MockClient((request) async {
      calls.add('${request.method} ${request.url.path}');
      if (request.method == 'POST') {
        rows.add({
          'id': 12,
          ...jsonDecode(request.body) as Map<String, dynamic>,
        });
        return http.Response(
          jsonEncode({'success': true, 'data': rows.single}),
          201,
        );
      }
      if (request.method == 'DELETE') {
        rows.clear();
        return http.Response(jsonEncode({'success': true, 'data': null}), 200);
      }
      return http.Response(jsonEncode({'success': true, 'data': rows}), 200);
    });
    final token = InMemoryTokenStore();
    await token.saveToken('test-token');
    await tester.pumpWidget(
      Provider<ApiClient>.value(
        value: ApiClient(httpClient: client, tokenStore: token),
        child: const MaterialApp(
          home: Scaffold(
            body: CrudScreen(title: 'Rumah Makan', entityType: 'rumahMakan'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tambah Data'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('admin-field-resto')),
      'Resto Baru',
    );
    await tester.enterText(find.byKey(const Key('admin-field-kulinerId')), '5');
    await tester.enterText(
      find.byKey(const Key('admin-field-link_gmaps')),
      'https://maps.google.com/new',
    );
    await tester.tap(find.byKey(const Key('admin-save')));
    await tester.pumpAndSettle();
    expect(find.text('Resto Baru'), findsOneWidget);
    await tester.tap(find.text('Hapus').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Hapus').last);
    await tester.pumpAndSettle();
    expect(find.text('Belum ada rumah makan di backend.'), findsOneWidget);
    expect(calls, [
      'GET /api/rumahMakan',
      'POST /api/rumahMakan',
      'GET /api/rumahMakan',
      'DELETE /api/rumahMakan/12',
      'GET /api/rumahMakan',
    ]);
    client.close();
  });
}
