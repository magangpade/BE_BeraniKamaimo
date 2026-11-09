import 'dart:convert';
import 'dart:typed_data';

import 'package:berani_kamaimo/core/network/api_client.dart';
import 'package:berani_kamaimo/core/network/token_store.dart';
import 'package:berani_kamaimo/core/theme/app_theme.dart';
import 'package:berani_kamaimo/features/admin/crud/desa_wisata_form_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  testWidgets(
    'tambah desa mengunggah foto dan mengirim lokasi serta kategori',
    (tester) async {
      tester.view.physicalSize = const Size(900, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final requests = <String>[];
      final client = MockClient((request) async {
        requests.add('${request.method} ${request.url.path}');
        expect(request.headers['authorization'], 'Bearer test-token');
        expect(
          request.headers['content-type'],
          contains('multipart/form-data'),
        );
        expect(
          latin1.decode(request.bodyBytes).toLowerCase(),
          contains('content-type: image/png'),
        );
        return http.Response(
          jsonEncode({
            'success': true,
            'data': {'foto': '/uploads/desa-test.png'},
          }),
          201,
        );
      });
      final tokenStore = InMemoryTokenStore();
      await tokenStore.saveToken('test-token');
      final api = ApiClient(httpClient: client, tokenStore: tokenStore);
      Map<String, dynamic>? saved;
      final png = Uint8List.fromList(
        base64Decode(
          'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAusB9Wl2tkwAAAAASUVORK5CYII=',
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: Builder(
              builder: (context) => Center(
                child: FilledButton(
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (_) => DesaWisataFormDialog(
                      api: api,
                      pickPhoto: () async => DesaPhoto('desa-test.png', png),
                      onSave: (body) async => saved = body,
                    ),
                  ),
                  child: const Text('Tambah Desa'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Tambah Desa'));
      await tester.pumpAndSettle();

      Future<void> fill(String key, String value) async {
        final field = find.byKey(Key('admin-field-$key'));
        await tester.ensureVisible(field);
        await tester.enterText(field, value);
      }

      await fill('namaDesa_id', 'Desa Uji');
      await fill('lokasi_id', 'Tentena, Poso');
      await fill('deskripsi_id', 'Destinasi budaya di tepi danau.');
      await tester.ensureVisible(find.byKey(const Key('admin-field-kategori')));
      await tester.tap(find.byKey(const Key('admin-field-kategori')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Budaya').last);
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.byKey(const Key('admin-pick-photo')));
      await tester.tap(find.byKey(const Key('admin-pick-photo')));
      await tester.pumpAndSettle();
      final map = find.byKey(const Key('admin-location-map'));
      await tester.ensureVisible(map);
      await tester.tap(map);
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.textContaining('Koordinat:'), findsOneWidget);

      await tester.ensureVisible(find.byKey(const Key('admin-save')));
      await tester.tap(find.byKey(const Key('admin-save')));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(requests, ['POST /api/desaWisata/upload']);
      expect(saved?['foto'], '/uploads/desa-test.png');
      expect(saved?['namaDesa_id'], 'Desa Uji');
      expect(saved?['kategori'], 'BUDAYA');
      expect(saved?['lokasi_id'], 'Tentena, Poso');
      expect(saved?['latitude'], isA<double>());
      expect(saved?['longitude'], isA<double>());
      client.close();
    },
  );
}
