import 'dart:convert';

import 'package:berani_kamaimo/core/network/api_client.dart';
import 'package:berani_kamaimo/core/network/token_store.dart';
import 'package:berani_kamaimo/features/admin/crud/crud_screen.dart';
import 'package:berani_kamaimo/features/admin/dashboard/dashboard_screen.dart';
import 'package:berani_kamaimo/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:provider/provider.dart';

Widget withApi(ApiClient api, Widget screen) => Provider<ApiClient>.value(
  value: api,
  child: MaterialApp(theme: AppTheme.light, home: screen),
);

void main() {
  testWidgets('ringkasan dashboard memakai jumlah dari enam endpoint', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(512, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final requested = <String>[];
    final client = MockClient((request) async {
      requested.add(request.url.path);
      final count = request.url.path == '/api/atraksi' ? 2 : 0;
      return http.Response(
        jsonEncode({
          'success': true,
          'data': List.generate(count, (i) => {'id': i}),
        }),
        200,
      );
    });
    await tester.pumpWidget(
      withApi(
        ApiClient(httpClient: client, tokenStore: InMemoryTokenStore()),
        const DashboardScreen(),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('Data backend terhubung'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('0'), findsNWidgets(5));
    expect(requested.toSet(), {
      '/api/desaWisata',
      '/api/jarak',
      '/api/atraksi',
      '/api/tourPackage',
      '/api/kuliner',
      '/api/hotel',
    });
    client.close();
  });

  testWidgets('tab admin menampilkan baris API, bukan data contoh', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(512, 736);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final client = MockClient(
      (request) async => http.Response(
        jsonEncode({
          'success': true,
          'data': [
            {
              'id': 41,
              'nameEvent': 'Festival dari API',
              'location_id': 'Poso',
              'description_id': 'Deskripsi asli backend',
              'kategori': 'BUDAYA',
            },
          ],
        }),
        200,
      ),
    );
    await tester.pumpWidget(
      withApi(
        ApiClient(httpClient: client, tokenStore: InMemoryTokenStore()),
        const Scaffold(
          body: CrudScreen(title: 'Atraksi & Event', entityType: 'atraksi'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('Festival dari API'), findsOneWidget);
    expect(find.text('1 Konten Terdaftar'), findsOneWidget);
    expect(find.text('Festival Danau Poso ke-24'), findsNothing);
    client.close();
  });

  testWidgets('kegagalan API tidak berubah menjadi angka atau daftar contoh', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final client = MockClient(
      (_) async => http.Response(
        jsonEncode({'success': false, 'message': 'Database unavailable'}),
        503,
      ),
    );
    final api = ApiClient(httpClient: client, tokenStore: InMemoryTokenStore());
    await tester.pumpWidget(withApi(api, const DashboardScreen()));
    await tester.pumpAndSettle();
    expect(find.text('Data backend tidak tersedia'), findsOneWidget);
    expect(find.text('—'), findsNWidgets(6));

    await tester.pumpWidget(
      withApi(
        api,
        const Scaffold(
          body: CrudScreen(title: 'Atraksi & Event', entityType: 'atraksi'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.text('Server sedang bermasalah. Coba lagi nanti.'),
      findsOneWidget,
    );
    expect(find.text('Festival Danau Poso ke-24'), findsNothing);
    client.close();
  });
}
