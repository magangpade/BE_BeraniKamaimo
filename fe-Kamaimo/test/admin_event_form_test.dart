import 'dart:convert';

import 'package:berani_kamaimo/core/network/api_client.dart';
import 'package:berani_kamaimo/core/network/token_store.dart';
import 'package:berani_kamaimo/features/admin/crud/admin_entity_form_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;

void main() {
  testWidgets('admin dapat menyusun event baru dengan program dan rundown', (tester) async {
    tester.view.physicalSize = const Size(900, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    Map<String, dynamic>? saved;
    final api = ApiClient(
      tokenStore: InMemoryTokenStore(),
      httpClient: MockClient((_) async => http.Response('{}', 200)),
    );
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: Center(child: AdminEntityFormDialog(
        title: 'Atraksi & Event', entityType: 'atraksi', api: api,
        onSave: (body) async => saved = body,
      ))),
    ));
    Future<void> fill(String key, String value) async {
      final field = find.byKey(Key(key));
      await tester.ensureVisible(field);
      await tester.enterText(field, value);
      await tester.pump();
    }
    await fill('admin-field-nameEvent', 'Festival Poso Baru');
    await fill('admin-field-location_id', 'Tentena, Poso');
    await fill('admin-field-description_id', 'Festival budaya danau.');
    await fill('admin-field-startdate', '2026-12-01');
    await fill('admin-field-enddate', '2026-12-02');
    await fill('admin-field-wilayah', 'Poso');
    await fill('admin-field-foto', 'https://example.com/festival.jpg');
    await tester.ensureVisible(find.text('Tambah program'));
    await tester.tap(find.text('Tambah program'));
    await tester.pump();
    await fill('admin-program-0-title', 'Tari Pamona');
    await fill('admin-program-0-description', 'Pertunjukan budaya.');
    await fill('admin-program-0-title-en', 'Pamona Dance');
    await tester.ensureVisible(find.text('Tambah hari'));
    await tester.tap(find.text('Tambah hari'));
    await tester.pump();
    await fill('admin-day-0', 'Hari 1 (1 Des)');
    await tester.ensureVisible(find.text('Tambah agenda'));
    await tester.tap(find.text('Tambah agenda'));
    await tester.pump();
    await fill('day-0-slot-0-jam', '08.00 WITA');
    await fill('day-0-slot-0-chip', 'Panggung Utama');
    await fill('day-0-slot-0-judul', 'Pembukaan');
    await fill('day-0-slot-0-deskripsi', 'Acara pembuka.');
    await tester.ensureVisible(find.byKey(const Key('admin-save')));
    await tester.tap(find.byKey(const Key('admin-save')));
    await tester.pumpAndSettle();
    expect(saved, isNotNull);
    expect(saved!['wilayah'], 'Poso');
    expect(saved!['startdate'], '2026-12-01');
    expect((jsonDecode(saved!['program_json'] as String) as List).single['title_en'], 'Pamona Dance');
    expect((jsonDecode(saved!['rundown_json'] as String) as List).single['items'][0]['judul'], 'Pembukaan');
  });
}
