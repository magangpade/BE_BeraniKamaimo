import 'package:flutter/material.dart';
import '../../../core/utils/constants.dart';

/// Halaman Sambutan (Launch Screen) sesuai desain Figma (430x932).
/// Tampil pertama kali saat aplikasi dibuka sebelum masuk ke Beranda (UserShell).
class HalamanSambutan extends StatelessWidget {
  const HalamanSambutan({super.key});

  void _onStart(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppConstants.routeHome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background atas hijau & bawah putih agar menyatu di segala rasio layar
          Column(
            children: [
              Expanded(
                flex: 6,
                child: Container(color: const Color(0xFF2E5C43)),
              ),
              Expanded(
                flex: 4,
                child: Container(color: const Color(0xFFFFFFFF)),
              ),
            ],
          ),
          Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: 430,
                height: 932,
                child: ClipRect(
                  child: Container(
                    width: 430,
                    height: 932,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFFFFF),
                    ),
                    alignment: Alignment.topLeft,
                    child: Stack(
                      alignment: Alignment.topLeft,
                      clipBehavior: Clip.none,
                      children: [
                        // Lingkaran besar latar hijau atas
                        Positioned(
                          left: -185,
                          top: -87,
                          child: Container(
                            width: 799,
                            height: 689,
                            decoration: const BoxDecoration(
                              color: Color(0xFF2E5C43),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),

                        // Lingkaran glow tengah
                        Positioned(
                          left: 75,
                          top: 202,
                          child: Opacity(
                            opacity: 0.4,
                            child: Container(
                              width: 300,
                              height: 280,
                              decoration: const BoxDecoration(
                                color: Color(0xFF679F7F),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),

                        // Logo tengah dalam lingkaran berlapis (120x120)
                        Positioned(
                          left: 155,
                          top: 312,
                          child: Container(
                            width: 120,
                            height: 120,
                            alignment: Alignment.topLeft,
                            child: Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    decoration: const BoxDecoration(
                                      color: Color(0x208CE1A6),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 16,
                                  top: 16,
                                  child: Container(
                                    width: 88,
                                    height: 88,
                                    decoration: const BoxDecoration(
                                      color: Color(0x408CE1A6),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  left: 41,
                                  top: 41,
                                  child: SizedBox(
                                    width: 38,
                                    height: 38,
                                    child: CustomPaint(
                                      painter: _KamaimoEmblemPainter(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Deskripsi bawah
                        const Positioned(
                          left: 55,
                          right: 55,
                          top: 778,
                          child: Text(
                            'Destinasi wisata terbaik Sulawesi Tengah\ndalam genggaman tanganmu.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF2E5C43),
                              height: 1.35,
                            ),
                          ),
                        ),

                        // Chip "Budaya"
                        Positioned(
                          left: 91,
                          top: 651,
                          child: Container(
                            width: 73,
                            height: 23,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: const Color(0xFF2E5C43),
                                width: 1,
                              ),
                            ),
                            child: const Text(
                              'Budaya',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF2E5C43),
                                height: 1.0,
                              ),
                            ),
                          ),
                        ),

                        // Chip "Alam"
                        Positioned(
                          left: 178,
                          top: 652,
                          child: Container(
                            width: 73,
                            height: 23,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: const Color(0xFF2E5C43),
                                width: 1,
                              ),
                            ),
                            child: const Text(
                              'Alam',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFF4B251),
                                height: 1.0,
                              ),
                            ),
                          ),
                        ),

                        // Chip "Festival"
                        Positioned(
                          left: 265,
                          top: 652,
                          child: Container(
                            width: 73,
                            height: 23,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: const Color(0xFF2E5C43),
                                width: 1,
                              ),
                            ),
                            child: const Text(
                              'Festival',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF8CB894),
                                height: 1.0,
                              ),
                            ),
                          ),
                        ),

                        // Tombol "Start"
                        Positioned(
                          left: 145,
                          top: 834,
                          child: GestureDetector(
                            onTap: () => _onStart(context),
                            behavior: HitTestBehavior.opaque,
                            child: SizedBox(
                              width: 139.78,
                              height: 43.17,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 139.44,
                                    height: 43.17,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF09903B),
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x40000000),
                                          blurRadius: 4,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text(
                                    'Start',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFFFFFFF),
                                      height: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Judul Utama: "Jelajahi Surga / Tersembunyi Sulteng"
                        Positioned(
                          left: 40,
                          right: 40,
                          top: 695,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                height: 1.33,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Jelajahi Surga\n',
                                  style: TextStyle(color: Color(0xFF467A5C)),
                                ),
                                TextSpan(
                                  text: 'Tersembunyi Sulteng',
                                  style: TextStyle(color: Color(0xFFF4B251)),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Header Logo BERANI KAMAIMO
                        Positioned(
                          left: 162,
                          top: 79,
                          child: SizedBox(
                            width: 118,
                            height: 38.94,
                            child: Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 38.6,
                                    height: 38.94,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF35644A),
                                      borderRadius: BorderRadius.circular(8.46),
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  left: 6,
                                  top: 6,
                                  child: SizedBox(
                                    width: 26,
                                    height: 26,
                                    child: CustomPaint(
                                      painter: _KamaimoEmblemPainter(),
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  left: 44,
                                  top: 8,
                                  child: Text(
                                    'BERANI\nKAMAIMO',
                                    style: TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontSize: 10.84,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFFFFFFF),
                                      height: 1.1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Badge "DINAS PARIWISATA SULTENG"
                        Positioned(
                          left: 112,
                          top: 129,
                          child: Container(
                            width: 206,
                            height: 23,
                            decoration: BoxDecoration(
                              color: const Color(0x33284D3D),
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: const Color(0xFFE2E8E0),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF8CE1A6),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFF8CE1A6),
                                        blurRadius: 3,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  'DINAS PARIWISATA SULTENG',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF8CE1A6),
                                    height: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Orbit Lingkaran + 6 Foto Destinasi + Titik Cahaya
                        Positioned(
                          left: 16,
                          top: 200,
                          child: SizedBox(
                            width: 400,
                            height: 348,
                            child: Stack(
                              alignment: Alignment.topLeft,
                              clipBehavior: Clip.none,
                              children: [
                                // Lingkaran orbit luar (340x340)
                                Positioned(
                                  left: 30,
                                  top: 0,
                                  child: Container(
                                    width: 340,
                                    height: 340,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0x18FFFFFF),
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),

                                // Lingkaran orbit dalam (260x260) + titik-titik cahaya
                                Positioned(
                                  left: 70,
                                  top: 40,
                                  child: SizedBox(
                                    width: 260,
                                    height: 260,
                                    child: Stack(
                                      alignment: Alignment.topLeft,
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 260,
                                            height: 260,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: const Color(0x10FFFFFF),
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Positioned(
                                          left: 29,
                                          top: 42,
                                          child: _GlowDot(
                                            color: Color(0xFFA7F3D0),
                                            shadowColor: Color(0xFF8CE1A6),
                                          ),
                                        ),
                                        const Positioned(
                                          left: 52,
                                          top: 230,
                                          child: _GlowDot(
                                            color: Color(0xFFA7F3D0),
                                            shadowColor: Color(0xFF8CE1A6),
                                          ),
                                        ),
                                        const Positioned(
                                          left: 255,
                                          top: 112,
                                          child: _GlowDot(
                                            color: Color(0xFFA7F3D0),
                                            shadowColor: Color(0xFF8CE1A6),
                                          ),
                                        ),
                                        const Positioned(
                                          left: 5,
                                          top: 177,
                                          child: _GlowDot(
                                            color: Color(0xFFF4B251),
                                            shadowColor: Color(0xFFF4B251),
                                          ),
                                        ),
                                        const Positioned(
                                          left: 214,
                                          top: 222,
                                          child: _GlowDot(
                                            color: Color(0xFFF4B251),
                                            shadowColor: Color(0xFFF4B251),
                                          ),
                                        ),
                                        const Positioned(
                                          left: 206,
                                          top: 26,
                                          child: _GlowDot(
                                            color: Color(0xFFF4B251),
                                            shadowColor: Color(0xFFF4B251),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // 6 Foto Destinasi Melingkar
                                const Positioned(
                                  left: 276,
                                  top: 6,
                                  child: _OrbitPhotoCircle(
                                    assetPath:
                                        'assets/images/destinasi/card_pulo_dua.png',
                                  ),
                                ),
                                const Positioned(
                                  left: 20,
                                  top: 58,
                                  child: _OrbitPhotoCircle(
                                    assetPath:
                                        'assets/images/destinasi/card_togean.png',
                                  ),
                                ),
                                const Positioned(
                                  left: 338,
                                  top: 156,
                                  child: _OrbitPhotoCircle(
                                    assetPath:
                                        'assets/images/beranda/kartu_kolam_kaca.png',
                                  ),
                                ),
                                const Positioned(
                                  left: 0,
                                  top: 196,
                                  child: _OrbitPhotoCircle(
                                    assetPath:
                                        'assets/images/destinasi/card_saluopa.png',
                                  ),
                                ),
                                const Positioned(
                                  left: 262,
                                  top: 280,
                                  child: _OrbitPhotoCircle(
                                    assetPath:
                                        'assets/images/destinasi/card_bada.png',
                                  ),
                                ),
                                const Positioned(
                                  left: 88,
                                  top: 288,
                                  child: _OrbitPhotoCircle(
                                    assetPath:
                                        'assets/images/detail_wisata/fasilitas_homestay.png',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget lingkaran foto destinasi 60x60 di garis orbit.
class _OrbitPhotoCircle extends StatelessWidget {
  final String assetPath;

  const _OrbitPhotoCircle({required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0x80E2E8E0), width: 2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          assetPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

/// Titik bercahaya pada cincin orbit dalam.
class _GlowDot extends StatelessWidget {
  final Color color;
  final Color shadowColor;

  const _GlowDot({required this.color, required this.shadowColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 4,
            spreadRadius: 1,
            offset: Offset.zero,
          ),
        ],
      ),
    );
  }
}

/// CustomPainter untuk menggambar ikon emblem Berani Kamaimo (hijau mint & emas).
class _KamaimoEmblemPainter extends CustomPainter {
  const _KamaimoEmblemPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final greenPaint = Paint()
      ..color = const Color(0xFF7CE8A6)
      ..style = PaintingStyle.fill;

    final goldPaint = Paint()
      ..color = const Color(0xFFF4B251)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = const Color(0xFF1D3A30)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.045
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Lingkaran kepala (kanan atas)
    final headCenter = Offset(w * 0.64, h * 0.22);
    final headRadius = w * 0.14;
    canvas.drawCircle(headCenter, headRadius, goldPaint);
    canvas.drawCircle(headCenter, headRadius, strokePaint);

    // Bagian kiri hijau mint (bahu/punggung melengkung)
    final greenPath = Path()
      ..moveTo(w * 0.50, h * 0.36)
      ..quadraticBezierTo(w * 0.18, h * 0.52, w * 0.10, h * 0.85)
      ..lineTo(w * 0.42, h * 0.85)
      ..quadraticBezierTo(w * 0.52, h * 0.60, w * 0.58, h * 0.42)
      ..close();
    canvas.drawPath(greenPath, greenPaint);
    canvas.drawPath(greenPath, strokePaint);

    // Bagian kanan bawah emas (lengan/badan)
    final goldPath = Path()
      ..moveTo(w * 0.58, h * 0.42)
      ..quadraticBezierTo(w * 0.88, h * 0.45, w * 0.82, h * 0.78)
      ..quadraticBezierTo(w * 0.78, h * 0.85, w * 0.65, h * 0.85)
      ..lineTo(w * 0.40, h * 0.85)
      ..quadraticBezierTo(w * 0.48, h * 0.60, w * 0.58, h * 0.42)
      ..close();
    canvas.drawPath(goldPath, goldPaint);
    canvas.drawPath(goldPath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
