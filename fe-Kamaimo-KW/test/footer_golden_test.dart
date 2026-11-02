import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:berani_kamaimo/features/user/destinasi/destinasi_screen.dart';
import 'package:berani_kamaimo/features/user/home/user_shell.dart';

const _copyright = '© 2026 Dinas Pariwisata Sulawesi Tengah. Hak Cipta Dilindungi.';

Future<void> _loadFonts() async {
  const weights = ['Regular', 'Medium', 'SemiBold', 'Bold', 'ExtraBold'];
  final loader = FontLoader('PlusJakartaSans');
  for (final w in weights) {
    loader.addFont(rootBundle.load('fonts/PlusJakartaSans-$w.ttf'));
  }
  await loader.load();
}

void main() {
  setUpAll(_loadFonts);

  Future<void> pumpSoft(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 2.625;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const MaterialApp(home: UserShell()));
    await tester.pumpAndSettle();
  }

  testWidgets('beranda: footer terlihat penuh + jarak nav saat discroll ke bawah',
      (tester) async {
    await pumpSoft(tester);
    // Scroll sampai mentok bawah lewat CustomScrollView beranda (bukan scrollable dalam).
    for (var i = 0; i < 30; i++) {
      await tester.drag(find.byType(Scrollable).first, const Offset(0, -4000));
      await tester.pump(const Duration(milliseconds: 50));
    }
    await tester.pumpAndSettle();
    expect(find.text(_copyright), findsOneWidget);
    // Konten footer tidak tertutup nav: copyright harus jelas di atas label nav.
    final copyright = tester.getRect(find.text(_copyright));
    final navLabel = tester.getRect(find.text('Beranda'));
    expect(
      copyright.bottom < navLabel.top - 20,
      true,
      reason:
          'copyright (bottom=${copyright.bottom}) harus di atas nav (label top=${navLabel.top})',
    );
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/beranda_bottom.png'),
    );
  });

  testWidgets('destinasi: footer terlihat penuh + jarak nav saat discroll ke bawah',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 2.625;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const MaterialApp(home: DestinasiScreen()));
    await tester.pumpAndSettle();
    for (var i = 0; i < 30; i++) {
      await tester.drag(find.byKey(const Key('destinasiScroll')), const Offset(0, -4000));
      await tester.pump(const Duration(milliseconds: 50));
    }
    await tester.pumpAndSettle();
    expect(find.text(_copyright), findsOneWidget);
    // Tunggu decode gambar selesai: golden lama pernah kecapture saat kartu terakhir masih kosong.
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 200)));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/destinasi_bottom.png'),
    );
  });
}
