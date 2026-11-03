import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:berani_kamaimo/features/user/detail_wisata/detail_wisata_screen.dart';

// Diagnosa 2: DetailWisataScreen dengan argumen produksi persis
// (loader default = fetch backend, viewport 430x932, foto asset).
void main() {
  testWidgets('detail wisata jalur produksi (tanpa injeksi loader)',
      (tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MaterialApp(
      home: DetailWisataScreen(
        desaId: 1,
        namaDesa: 'Luk Panenteng & Danau Paisu Pok',
        lokasi: 'Banggai Kepulauan',
        foto: 'assets/images/destinasi/feat_luk_panenteng.png',
      ),
    ));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    final texts = tester
        .widgetList<Text>(find.byType(Text))
        .map((t) => t.data ?? (t.textSpan?.toPlainText() ?? '<span>'))
        .toSet()
        .toList();
    debugPrint('=== TEKS (${texts.length}) ===');
    for (final t in texts.take(45)) {
      debugPrint(' - [$t]');
    }
    debugPrint('=== Scaffold: ${tester.widgetList<Scaffold>(find.byType(Scaffold)).length} ===');
  });
}
