import 'package:berani_kamaimo/features/user/event/detail_event_screen.dart';
import 'package:berani_kamaimo/features/user/event/event_data.dart';
import 'package:berani_kamaimo/features/user/event/event_detail_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final events = [EventSeed.featured, ...EventSeed.agenda];

  test('setiap kartu Event memiliki detail yang sesuai dan jadwal selaras', () {
    expect(events.length, 9);
    for (final event in events) {
      final detail = EventDetailSeed.of(event.nama);
      final words = detail.tentang.trim().split(RegExp(r'\s+')).length;
      expect(words, inInclusiveRange(28, 85), reason: event.nama);
      expect(detail.lokasi, isNot('Lokasi belum diisi'), reason: event.nama);
      expect(detail.program.length, inInclusiveRange(3, 4), reason: event.nama);
      final totalHari =
          (event.end ?? event.start).difference(event.start).inDays + 1;
      expect(detail.rundown.length, totalHari, reason: event.nama);
      expect(detail.akses.length, 2, reason: event.nama);
      expect(detail.mapLabel, isNotEmpty, reason: event.nama);
      expect(
        detail.mapAsset != null ||
            (detail.mapLatitude != null && detail.mapLongitude != null),
        isTrue,
        reason: event.nama,
      );
      expect(event.end, isNotNull, reason: event.nama);
      for (final program in detail.program) {
        final parts = program.split('|');
        expect(parts.length, 2, reason: event.nama);
        expect(parts.first, isNotEmpty, reason: event.nama);
        expect(
          parts.last.trim().split(RegExp(r'\s+')).length,
          inInclusiveRange(6, 25),
          reason: event.nama,
        );
      }
      for (final day in detail.rundown) {
        final items = day['items'] as List;
        expect(items.length, inInclusiveRange(2, 3), reason: event.nama);
        for (final item in items) {
          final entry = item as Map<String, dynamic>;
          expect(entry['judul'], isNot('-'), reason: event.nama);
          expect(entry['deskripsi'], isNot('-'), reason: event.nama);
        }
      }
    }
  });

  testWidgets(
    'detail Danau Poso menampilkan isi khusus dan tiga hari rundown',
    (tester) async {
      tester.view.physicalSize = const Size(430, 932);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(home: DetailEventScreen(event: EventSeed.featured)),
      );
      await tester.pump();
      expect(find.text('Festival Danau Poso ke-24'), findsOneWidget);
      expect(find.text('Budaya'), findsOneWidget);
      expect(find.text('3 Hari Penuh'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.scrollUntilVisible(
        find.text('Tarian Massal Kolosal Motaro'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('Parade Perahu Hias Pamona'), findsOneWidget);
      expect(find.text('Festival Kuliner Ikan Sogili Bakar'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.scrollUntilVisible(
        find.text('Hari 3 (26 Okt)'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Hari 3 (26 Okt)'));
      await tester.pump();
      expect(find.text('Pertunjukan Budaya Pamona'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.scrollUntilVisible(
        find.text('Anjungan Danau Poso, Tentena'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('Dari Bandara Kasiguncu Poso'), findsOneWidget);
      await tester.scrollUntilVisible(
        find.text('Dispar Sulteng & Pemkab Poso'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      expect(tester.takeException(), isNull);
    },
  );
}
