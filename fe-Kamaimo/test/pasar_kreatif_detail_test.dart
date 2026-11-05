import 'package:berani_kamaimo/features/user/event/detail_event_screen.dart';
import 'package:berani_kamaimo/features/user/event/event_data.dart';
import 'package:berani_kamaimo/features/user/event/widgets/event_countdown_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Detail Pasar Kreatif menampilkan isi frame tanpa layout error', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(home: DetailEventScreen(event: EventSeed.agenda.first)),
    );
    await tester.pump();

    expect(find.text('Pasar Kreatif Sulawesi Tengah'), findsOneWidget);
    expect(find.byType(EventCountdownCard), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.drag(find.byType(CustomScrollView), const Offset(0, -1400));
    await tester.pump();
    expect(find.text('Jadwal & Rundown'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.ensureVisible(find.text('Hari 2 (1 Nov)'));
    await tester.tap(find.text('Hari 2 (1 Nov)'));
    await tester.pump();
    expect(find.text('Cerita Rasa Sulteng'), findsOneWidget);
    expect(find.text('Showcase Produk Kreatif'), findsOneWidget);
    expect(find.text('Apresiasi UMKM & Penutupan'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Bagikan Event membuka lembar dan menjelaskan tautan pratinjau', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(home: DetailEventScreen(event: EventSeed.agenda.first)),
    );
    await tester.tap(find.byTooltip('Bagikan'));
    await tester.pumpAndSettle();

    expect(find.text('Bagikan Event'), findsOneWidget);
    expect(find.text('Pasar Kreatif'), findsOneWidget);
    expect(find.text('WhatsApp'), findsOneWidget);
    expect(find.text('SALIN TAUTAN'), findsOneWidget);

    await tester.ensureVisible(find.text('SALIN TAUTAN'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('SALIN TAUTAN'));
    await tester.pump();
    expect(find.text('Tautan publik event belum tersedia.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
