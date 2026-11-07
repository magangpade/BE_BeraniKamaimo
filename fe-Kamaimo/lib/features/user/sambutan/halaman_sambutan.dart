import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/language_provider.dart';
import '../../../core/utils/constants.dart';

/// Halaman Sambutan (Launch Screen) sesuai desain Figma dengan animasi orbit berputar otomatis.
/// Tampil pertama kali saat aplikasi dibuka sebelum masuk ke Beranda (UserShell).
class HalamanSambutan extends StatefulWidget {
  const HalamanSambutan({super.key});

  @override
  State<HalamanSambutan> createState() => _HalamanSambutanState();
}

class _HalamanSambutanState extends State<HalamanSambutan>
    with SingleTickerProviderStateMixin {
  late final AnimationController _orbitController;

  // 6 foto destinasi Sulawesi Tengah yang bersih (tanpa teks/badge terpotong)
  static const List<String> _orbitPhotos = [
    'assets/images/detail_wisata/hero_luk_panenteng.png',
    'assets/images/paket/figma_package_asset_3.png',
    'assets/images/detail_wisata/fasilitas_homestay.png',
    'assets/images/paket/figma_package_asset_4.png',
    'assets/images/detail_wisata/fasilitas_kano.png',
    'assets/images/paket/figma_package_asset_1.png',
  ];

  @override
  void initState() {
    super.initState();
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 24),
    )..repeat();
  }

  @override
  void dispose() {
    _orbitController.dispose();
    super.dispose();
  }

  void _onStart(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppConstants.routeHome);
  }

  @override
  Widget build(BuildContext context) {
    final isEn = context.watch<LanguageProvider>().isEnglish;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Background Hijau Melengkung Mulus dari ujung kiri ke ujung kanan layar (tanpa patahan)
          const Positioned.fill(
            child: CustomPaint(
              painter: _CurvedGreenBackgroundPainter(),
            ),
          ),

          // 2. Konten Utama Proporsional (mengikuti kanvas 430x932 Figma)
          Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: 430,
                height: 932,
                child: Column(
                  children: [
                    const SizedBox(height: 68),

                    // Header Logo BERANI KAMAIMO
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 39,
                          height: 39,
                          padding: const EdgeInsets.all(6.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF35644A),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: const CustomPaint(
                            painter: _KamaimoEmblemPainter(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'BERANI\nKAMAIMO',
                          style: TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 11.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFFFFFFF),
                            height: 1.12,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Badge "DINAS PARIWISATA SULTENG"
                    Container(
                      width: 214,
                      height: 25,
                      decoration: BoxDecoration(
                        color: const Color(0x33284D3D),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: const Color(0xB3E2E8E0),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 6.5,
                            height: 6.5,
                            decoration: const BoxDecoration(
                              color: Color(0xFF8CE1A6),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF8CE1A6),
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 7),
                          const Text(
                            'DINAS PARIWISATA SULTENG',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 10.8,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF8CE1A6),
                              letterSpacing: 0.3,
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 3. Sistem Orbit Konsentris (100% Simetris di Titik Tengah & Berputar Otomatis)
                    SizedBox(
                      width: 390,
                      height: 390,
                      child: AnimatedBuilder(
                        animation: _orbitController,
                        builder: (context, _) {
                          final double progress = _orbitController.value;
                          final double outerRotation = progress * 2 * math.pi;
                          final double innerRotation =
                              -progress * 2 * math.pi * 0.75;
                          final double pulse =
                              math.sin(progress * 4 * math.pi) * 0.04;

                          const double outerRadius = 164.0;
                          const double innerRadius = 122.0;

                          return Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.none,
                            children: [
                              // Lingkaran Glow Tengah (100% di titik pusat yang sama)
                              Container(
                                width: 280,
                                height: 280,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF679F7F)
                                      .withValues(alpha: 0.36),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF679F7F)
                                          .withValues(alpha: 0.28),
                                      blurRadius: 28,
                                      spreadRadius: 4,
                                    ),
                                  ],
                                ),
                              ),

                              // Garis Lingkaran Orbit Luar (diameter = 328)
                              Container(
                                width: outerRadius * 2,
                                height: outerRadius * 2,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0x22FFFFFF),
                                    width: 1.6,
                                  ),
                                ),
                              ),

                              // Garis Lingkaran Orbit Dalam (diameter = 244)
                              Container(
                                width: innerRadius * 2,
                                height: innerRadius * 2,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0x16FFFFFF),
                                    width: 1.5,
                                  ),
                                ),
                              ),

                              // Lingkaran Halo Tengah Luar (120x120)
                              Transform.scale(
                                scale: 1.0 + pulse,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: const BoxDecoration(
                                    color: Color(0x228CE1A6),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),

                              // Lingkaran Halo Tengah Dalam (88x88)
                              Container(
                                width: 88,
                                height: 88,
                                decoration: const BoxDecoration(
                                  color: Color(0x458CE1A6),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x338CE1A6),
                                      blurRadius: 20,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                              ),

                              // Ikon Emblem Tengah (40x40)
                              const SizedBox(
                                width: 40,
                                height: 40,
                                child: CustomPaint(
                                  painter: _KamaimoEmblemPainter(),
                                ),
                              ),

                              // 6 Titik Cahaya di Garis Orbit Dalam (Seimbang 60° & Berputar Mulus)
                              for (int i = 0; i < 6; i++)
                                Builder(
                                  builder: (_) {
                                    final double angle = (i * math.pi / 3) -
                                        (math.pi / 4) +
                                        innerRotation;
                                    final double dx =
                                        innerRadius * math.cos(angle);
                                    final double dy =
                                        innerRadius * math.sin(angle);
                                    final bool isGreen = i.isEven;

                                    return Transform.translate(
                                      offset: Offset(dx, dy),
                                      child: _GlowDot(
                                        color: isGreen
                                            ? const Color(0xFFA7F3D0)
                                            : const Color(0xFFF4B251),
                                        shadowColor: isGreen
                                            ? const Color(0xFF8CE1A6)
                                            : const Color(0xFFF4B251),
                                      ),
                                    );
                                  },
                                ),

                              // 6 Foto Destinasi di Garis Orbit Luar (Seimbang 60°, Berputar Otomatis & Tetap Tegak)
                              for (int i = 0; i < _orbitPhotos.length; i++)
                                Builder(
                                  builder: (_) {
                                    final double angle = (i * math.pi / 3) -
                                        (math.pi / 3.2) +
                                        outerRotation;
                                    final double dx =
                                        outerRadius * math.cos(angle);
                                    final double dy =
                                        outerRadius * math.sin(angle);

                                    return Transform.translate(
                                      offset: Offset(dx, dy),
                                      child: _OrbitPhotoCircle(
                                        assetPath: _orbitPhotos[i],
                                      ),
                                    );
                                  },
                                ),
                            ],
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 68),

                    // 4. Tiga Chip Kategori: Budaya, Alam, Festival
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _CategoryPill(
                          label: isEn ? 'Culture' : 'Budaya',
                          textColor: const Color(0xFF2E5C43),
                        ),
                        const SizedBox(width: 14),
                        _CategoryPill(
                          label: isEn ? 'Nature' : 'Alam',
                          textColor: const Color(0xFFF4B251),
                        ),
                        const SizedBox(width: 14),
                        const _CategoryPill(
                          label: 'Festival',
                          textColor: Color(0xFF8CB894),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // 5. Judul Utama: "Jelajahi Surga / Tersembunyi Sulteng"
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          height: 1.3,
                        ),
                        children: [
                          TextSpan(
                            text: isEn
                                ? 'Explore the Hidden\n'
                                : 'Jelajahi Surga\n',
                            style: const TextStyle(
                              color: Color(0xFF467A5C),
                            ),
                          ),
                          TextSpan(
                            text: isEn
                                ? 'Paradise of Central Sulawesi'
                                : 'Tersembunyi Sulteng',
                            style: const TextStyle(
                              color: Color(0xFFF4B251),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // 6. Subjudul Deskripsi
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Text(
                        isEn
                            ? 'The best tourist destinations of Central Sulawesi\nin the palm of your hand.'
                            : 'Destinasi wisata terbaik Sulawesi Tengah\ndalam genggaman tanganmu.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF2E5C43),
                          height: 1.4,
                        ),
                      ),
                    ),

                    const SizedBox(height: 26),

                    // 7. Tombol "Start"
                    GestureDetector(
                      onTap: () => _onStart(context),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 142,
                        height: 44,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFF09903B),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x38000000),
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Text(
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Painter untuk latar belakang hijau atas dengan lengkungan kurva bawah yang mulus dari ujung kiri ke ujung kanan layar.
class _CurvedGreenBackgroundPainter extends CustomPainter {
  const _CurvedGreenBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2E5C43)
      ..style = PaintingStyle.fill;

    // Proporsi lengkungan sama persis dengan desain Figma (58.5% di pinggir, melengkung hingga ~64.6% di tengah)
    final double sideY = size.height * 0.585;
    final double bottomControlY = size.height * 0.708;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, sideY)
      ..quadraticBezierTo(
        size.width * 0.5,
        bottomControlY,
        size.width,
        sideY,
      )
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Pill kategori (Budaya, Alam, Festival).
class _CategoryPill extends StatelessWidget {
  final String label;
  final Color textColor;

  const _CategoryPill({
    required this.label,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: const Color(0xFF2E5C43),
          width: 1,
        ),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: textColor,
          height: 1.0,
        ),
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
        border: Border.all(color: const Color(0xCCE2E8E0), width: 2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x2E000000),
            blurRadius: 8,
            offset: Offset(0, 3),
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
      width: 8.5,
      height: 8.5,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 6,
            spreadRadius: 1.5,
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
      ..strokeWidth = w * 0.042
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Lingkaran kepala (kanan atas)
    final headCenter = Offset(w * 0.64, h * 0.22);
    final headRadius = w * 0.135;
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
