import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:berani_kamaimo/core/providers/language_provider.dart';
import 'package:berani_kamaimo/features/user/detail_wisata/widgets/destinasi_share_sheet.dart';

Widget _wrap(Widget child, [LanguageProvider? lang]) {
  return ChangeNotifierProvider<LanguageProvider>(
    create: (_) => lang ?? LanguageProvider(),
    child: MaterialApp(home: child),
  );
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (message) async {
      return null;
    });
  });

  testWidgets('showDestinasiShareSheet displays destination info and options',
      (tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_wrap(
      Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () => showDestinasiShareSheet(
                context,
                namaDesa: 'Danau Paisu Pok',
                lokasi: 'Banggai Kepulauan',
                foto: 'assets/images/destinasi/feat_luk_panenteng.png',
                kategori: 'Bahari',
              ),
              child: const Text('Open Share'),
            ),
          ),
        ),
      ),
    ));

    await tester.tap(find.text('Open Share'));
    await tester.pumpAndSettle();

    // Check header
    expect(find.text('Bagikan Destinasi'), findsOneWidget);
    expect(find.textContaining('Danau Paisu Pok'), findsWidgets);

    // Check share options
    expect(find.text('Bagikan melalui'), findsOneWidget);
    expect(find.text('WhatsApp'), findsOneWidget);
    expect(find.text('Telegram'), findsOneWidget);
    expect(find.text('Facebook'), findsOneWidget);
    expect(find.text('Lainnya'), findsOneWidget);

    // Check link & copy button
    expect(find.text('Tautan destinasi'), findsOneWidget);
    expect(find.text('SALIN TAUTAN'), findsOneWidget);
    expect(find.text('Batal'), findsOneWidget);

    // Scroll to copy button & tap
    await tester.ensureVisible(find.text('SALIN TAUTAN'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('SALIN TAUTAN'));
    await tester.pumpAndSettle();
    expect(find.text('Tautan publik destinasi belum tersedia.'), findsOneWidget);

    // Tap cancel
    await tester.tap(find.text('Batal'));
    await tester.pumpAndSettle();
    expect(find.text('Bagikan Destinasi'), findsNothing);
  });

  testWidgets('showDestinasiShareSheet in English mode', (tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    SharedPreferences.setMockInitialValues({'app_locale': 'en'});
    final lang = LanguageProvider();
    await tester.pump();

    await tester.pumpWidget(_wrap(
      Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () => showDestinasiShareSheet(
                context,
                namaDesa: 'Luk Panenteng Lake',
                lokasi: 'Banggai Islands',
                foto: '',
              ),
              child: const Text('Open Share'),
            ),
          ),
        ),
      ),
      lang,
    ));

    await tester.tap(find.text('Open Share'));
    await tester.pumpAndSettle();

    expect(find.text('Share Destination'), findsOneWidget);
    expect(find.text('Share via'), findsOneWidget);
    expect(find.text('More'), findsOneWidget);
    expect(find.text('Destination link'), findsOneWidget);
    expect(find.text('COPY LINK'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });
}
