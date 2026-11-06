import 'package:berani_kamaimo/core/providers/language_provider.dart';
import 'package:berani_kamaimo/data/repositories/paket_rating_repository.dart';
import 'package:berani_kamaimo/features/user/paket/paket_data.dart';
import 'package:berani_kamaimo/features/user/paket/paket_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _app(LanguageProvider language) => ChangeNotifierProvider.value(
  value: language,
  child: const MaterialApp(home: Scaffold(body: PaketScreen())),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({'app_locale': 'id'}));

  testWidgets('Tab Paket: hero, kartu carousel, dan filter kategori', (
    tester,
  ) async {
    await tester.pumpWidget(_app(LanguageProvider()));
    await tester.pumpAndSettle();

    expect(find.text('Paket Tur Wisata'), findsOneWidget);
    // Kartu pertama carousel (Togean) tampil.
    expect(find.text('Rp 2.850.000'), findsOneWidget);
    expect(find.text('4 Hari 3 Malam'), findsOneWidget);

    // Filter Trekking menampilkan paket Lore Lindu dan Saluopa.
    await tester.tap(find.text('Trekking'));
    await tester.pumpAndSettle();
    expect(find.text('Eksotisme Kepulauan Togean'), findsNothing);
    expect(
      find.text('Ekspedisi Lore Lindu & Puncak Rore Kautimbu'),
      findsWidgets,
    );
    expect(find.text('Trekking Air Terjun Saluopa'), findsOneWidget);
    expect(find.text('Rp 2.150.000'), findsOneWidget);
  });

  testWidgets('Tab Paket: pencarian memfilter kartu', (tester) async {
    await tester.pumpWidget(_app(LanguageProvider()));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'togean');
    await tester.pumpAndSettle();
    expect(find.text('Eksotisme Kepulauan Togean'), findsOneWidget);
    expect(find.text('Sombori Secret Paradise'), findsNothing);

    await tester.enterText(find.byType(TextField), 'zzz');
    await tester.pumpAndSettle();
    expect(find.text('Belum ada paket untuk filter ini'), findsOneWidget);
  });

  testWidgets('Paket switches all visible labels and package copy to English', (
    tester,
  ) async {
    final language = LanguageProvider();
    await tester.pumpWidget(_app(language));
    await tester.pumpAndSettle();

    expect(find.text('Paket Tur Wisata'), findsOneWidget);
    await language.setLanguage('en');
    await tester.pumpAndSettle();

    expect(find.text('Travel Packages'), findsOneWidget);
    expect(find.text('The Exotic Togean Islands'), findsOneWidget);
    expect(find.text('Contact Agent on WhatsApp'), findsWidgets);
    expect(find.text('Paket Tur Wisata'), findsNothing);
    expect(find.text('FASILITAS TERMASUK:'), findsNothing);

    await tester.tap(
      find.byKey(
        Key('paket-rating-trigger-${PaketSeed.items.first.ratingKey}'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Rate this package'), findsOneWidget);
    expect(find.text('Your rating'), findsOneWidget);
    expect(find.text('SUBMIT'), findsOneWidget);
  });

  testWidgets('WhatsApp CTA opens a package contact sheet', (tester) async {
    await tester.pumpWidget(_app(LanguageProvider()));
    await tester.pumpAndSettle();

    await tester.drag(
      find.byKey(const Key('paketScroll')),
      const Offset(0, -500),
    );
    await tester.pumpAndSettle();
    final contactButton = find.text('Hubungi Agen via WhatsApp').first;
    await tester.ensureVisible(contactButton);
    await tester.tap(contactButton);
    await tester.pumpAndSettle();

    expect(find.text('Hubungi agen wisata'), findsOneWidget);
    expect(find.text('Eksotisme Kepulauan Togean'), findsWidgets);
    expect(find.text('Lanjutkan ke WhatsApp'), findsOneWidget);
  });

  testWidgets('Rating popup accepts and remembers a package rating', (
    tester,
  ) async {
    await tester.pumpWidget(_app(LanguageProvider()));
    await tester.pumpAndSettle();

    final package = PaketSeed.items.first;
    final trigger = find.byKey(
      Key('paket-rating-trigger-${package.ratingKey}'),
    );
    await tester.tap(trigger);
    await tester.pumpAndSettle();

    expect(find.text('Beri rating'), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(find.byKey(const Key('paket-rating-submit')))
          .onPressed,
      isNull,
    );
    await tester.tap(find.byKey(const Key('paket-rating-star-4')));
    await tester.pump();
    expect(find.text('4 dari 5 · Bagus'), findsOneWidget);
    await tester.tap(find.byKey(const Key('paket-rating-submit')));
    await tester.pumpAndSettle();
    expect(find.text('Beri rating'), findsNothing);
    expect(await PaketRatingRepository().getMyRating(package.ratingKey), 4);

    await tester.tap(trigger);
    await tester.pumpAndSettle();
    expect(find.text('4 dari 5 · Bagus'), findsOneWidget);
  });

  test('package ratings use separate saved keys', () async {
    final repository = PaketRatingRepository();
    final first = PaketSeed.items[0];
    final second = PaketSeed.items[1];

    expect(await repository.submit(first.ratingKey, 5), isTrue);
    expect(await repository.getMyRating(first.ratingKey), 5);
    expect(await repository.getMyRating(second.ratingKey), isNull);
  });
}
