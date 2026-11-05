import 'dart:convert';

import 'package:berani_kamaimo/core/network/api_client.dart';
import 'package:berani_kamaimo/core/network/token_store.dart';
import 'package:berani_kamaimo/data/repositories/event_rating_repository.dart';
import 'package:berani_kamaimo/features/user/event/detail_event_screen.dart';
import 'package:berani_kamaimo/features/user/event/event_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets(
    'rating Event tersimpan melalui API dan agregat di kartu diperbarui',
    (tester) async {
      tester.view.physicalSize = const Size(430, 932);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      SharedPreferences.setMockInitialValues({});

      final requests = <http.Request>[];
      final client = MockClient((request) async {
        requests.add(request);
        expect(
          request.url.path,
          '/api/event-rating/${EventSeed.agenda.first.ratingKey}',
        );
        if (request.method == 'GET') {
          return http.Response(
            jsonEncode({
              'success': true,
              'data': {'rating': null, 'ratingCount': 0, 'myRating': null},
            }),
            200,
          );
        }
        expect(request.method, 'POST');
        expect(jsonDecode(request.body)['rating'], 4);
        return http.Response(
          jsonEncode({
            'success': true,
            'data': {'rating': 4, 'ratingCount': 1, 'myRating': 4},
          }),
          200,
        );
      });
      final repository = EventRatingRepository(
        ApiClient(httpClient: client, tokenStore: InMemoryTokenStore()),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: DetailEventScreen(
            event: EventSeed.agenda.first,
            ratingRepository: repository,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Baru'), findsOneWidget);
      await tester.tap(find.byKey(const Key('event-rating-trigger')));
      await tester.pumpAndSettle();
      expect(find.text('Beri rating'), findsOneWidget);
      expect(
        tester
            .widget<FilledButton>(find.byKey(const Key('event-rating-submit')))
            .onPressed,
        isNull,
      );
      await tester.tap(find.byKey(const Key('event-rating-star-4')));
      await tester.pump();
      expect(find.text('4 dari 5 · Bagus'), findsOneWidget);
      await tester.tap(find.byKey(const Key('event-rating-submit')));
      await tester.pumpAndSettle();
      expect(find.text('Beri rating'), findsNothing);
      expect(find.text('4.0'), findsOneWidget);
      expect(find.text('(1)'), findsOneWidget);
      expect(requests.map((request) => request.method), ['GET', 'POST']);
      expect(
        requests.first.url.queryParameters['visitorKey'],
        jsonDecode(requests.last.body)['visitorKey'],
      );

      await tester.tap(find.byKey(const Key('event-rating-trigger')));
      await tester.pumpAndSettle();
      expect(find.text('4 dari 5 · Bagus'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  test('setiap Event memiliki kunci rating sendiri', () {
    expect(
      EventSeed.agenda.first.ratingKey,
      isNot(EventSeed.agenda[1].ratingKey),
    );
  });
}
