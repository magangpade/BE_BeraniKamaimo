import 'package:berani_kamaimo/core/providers/language_provider.dart';
import 'package:berani_kamaimo/features/user/event/event_screen.dart';
import 'package:berani_kamaimo/features/user/event/event_data.dart';
import 'package:berani_kamaimo/features/user/event/event_locale.dart';
import 'package:berani_kamaimo/features/user/event/widgets/event_agenda_card.dart';
import 'package:berani_kamaimo/features/user/event/widgets/featured_event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    final fonts = FontLoader('PlusJakartaSans')
      ..addFont(rootBundle.load('fonts/PlusJakartaSans-Regular.ttf'))
      ..addFont(rootBundle.load('fonts/PlusJakartaSans-Bold.ttf'));
    await fonts.load();
  });

  testWidgets('kartu unggulan mengikuti posisi lokasi, tanggal, dan tombol', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(382, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: FeaturedEventCard(
              item: EventSeed.featured,
              now: DateTime(2026, 10, 6),
              onTap: () {},
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    final category = tester.getRect(find.text('Budaya'));
    final location = tester.getRect(find.text('Tentena, Poso'));
    final date = tester.getRect(find.text('24 - 26 Oktober 2026'));
    final button = tester.getRect(
      find.byKey(const Key('featured-event-detail-button')),
    );
    expect(location.center.dy, closeTo(category.center.dy, 2));
    expect(location.left, greaterThan(category.right));
    expect(button.top, greaterThan(date.bottom));
    expect(button.right, greaterThan(300));
    expect(button.width, inInclusiveRange(80, 105));
    expect(button.height, 27);
    expect(
      tester.getSize(find.byType(FeaturedEventCard)).height,
      inInclusiveRange(340, 370),
    );
    expect(find.byIcon(Icons.star_rounded), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('semua kartu agenda menempatkan lokasi tanpa rating', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(382, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    for (final event in EventSeed.agenda) {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EventAgendaCard(item: event, onTap: () {}),
          ),
        ),
      );
      await tester.pump();
      expect(
        find.text(EventLocale.cardLocation(event, false)),
        findsOneWidget,
        reason: event.nama,
      );
      expect(find.byIcon(Icons.star_rounded), findsNothing, reason: event.nama);
      expect(tester.takeException(), isNull, reason: event.nama);
    }
  });

  testWidgets('Tab Event: section, featured, dan filter kategori tampil', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({'app_locale': 'id'});
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => LanguageProvider(),
        child: const MaterialApp(home: Scaffold(body: EventScreen())),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Agenda mendatang'), findsOneWidget);
    expect(find.text('Festival Danau Poso ke-24'), findsOneWidget);

    // Filter UMKM: featured & event Budaya hilang, kartu UMKM tampil.
    await tester.tap(find.text('UMKM'));
    await tester.pumpAndSettle();
    expect(find.text('Festival Danau Poso ke-24'), findsNothing);
    expect(find.text('Pasar Kreatif Sulteng'), findsOneWidget);
    expect(find.text('Jelajah Megalitikum Lore'), findsNothing);
  });

  testWidgets('switch bahasa menerjemahkan kartu, lokasi, dan detail Event', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({'app_locale': 'id'});
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final language = LanguageProvider();
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: language,
        child: const MaterialApp(home: Scaffold(body: EventScreen())),
      ),
    );
    await tester.pumpAndSettle();
    await language.setLanguage('en');
    await tester.pumpAndSettle();
    expect(find.text('Upcoming events'), findsOneWidget);
    expect(find.text('Pasar Kreatif Sulteng'), findsNothing);

    await tester.tap(find.text('MSME').first);
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Central Sulawesi Creative Market'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Taman GOR, Palu'), findsOneWidget);
    await tester.tap(find.text('Central Sulawesi Creative Market'));
    await tester.pumpAndSettle();
    expect(find.text('Central Sulawesi Creative Market'), findsOneWidget);
    expect(find.text('Save to My Calendar'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('About the Festival'), 250);
    expect(find.text('About the Festival'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
