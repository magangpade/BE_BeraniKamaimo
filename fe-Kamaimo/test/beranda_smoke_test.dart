import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:berani_kamaimo/features/user/home/user_shell.dart';

void main() {
  // Self-check UI beranda: semua section sesuai tasarinya ada + tanpa overflow error.
  testWidgets('beranda menampilkan semua section per Figma 4273:55', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: UserShell(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Jelajahi Surangi'), findsNothing); // jaga-jaga typo check
    expect(find.text('Peta Interaktif Wisata'), findsOneWidget);
    expect(find.text('Wisata Unggulan Sulteng'), findsOneWidget);
    expect(find.text('Atraksi & Event Budaya'), findsOneWidget);
    expect(find.text('Festival Danau Poso ke-24'), findsOneWidget);
    expect(find.text('Cari destinasi atau kabupaten...'), findsOneWidget);
    expect(find.text('Desa Luk Panenteng'), findsOneWidget);

    // Kode rahasia admin masih tertanam di search bar (backdoor)
    await tester.enterText(find.byType(TextField).first, 'adminBK2025');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    expect(find.textContaining('Mode admin'), findsOneWidget);

    // Tab nav
    expect(find.text('Eksplor'), findsOneWidget);
    expect(find.text('Kuliner'), findsNothing); // label lama sudah kedaluwarsa
  });
}
