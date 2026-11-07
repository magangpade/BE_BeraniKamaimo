import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:berani_kamaimo/core/providers/language_provider.dart';
import 'package:berani_kamaimo/features/user/home/user_shell.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  // Self-check UI beranda: semua section sesuai tasarinya ada + tanpa overflow error.
  testWidgets('beranda menampilkan semua section per Figma 4273:55', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<LanguageProvider>(
        create: (_) => LanguageProvider(),
        child: MaterialApp(
          home: const UserShell(),
          routes: {
            '/admin-login': (_) => const Scaffold(body: Text('Portal Admin')),
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Jelajahi Surangi'), findsNothing); // jaga-jaga typo check
    expect(find.text('Peta Interaktif Wisata'), findsOneWidget);
    expect(find.text('Wisata Unggulan Sulteng'), findsOneWidget);
    expect(find.text('Atraksi & Event Budaya'), findsOneWidget);
    expect(find.text('Festival Danau Poso ke-24'), findsOneWidget);
    expect(find.text('Cari destinasi atau kabupaten...'), findsOneWidget);
    expect(find.textContaining('Luk Panenteng'), findsWidgets);

    // Tab nav
    expect(find.text('Eksplor'), findsOneWidget);
    expect(find.text('Kuliner'), findsNothing); // label lama sudah kedaluwarsa

    // Kode rahasia admin langsung membuka form login admin
    await tester.enterText(find.byType(TextField).first, 'adminBK2025');
    await tester.pumpAndSettle();
    expect(find.text('Portal Admin'), findsOneWidget);
  });
}
