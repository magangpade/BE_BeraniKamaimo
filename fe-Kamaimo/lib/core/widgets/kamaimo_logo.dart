import 'package:flutter/material.dart';

/// Ikon Logo Resmi Berani Kamaimo (Emblem Hijau & Emas).
/// Menggunakan CustomPainter vektor presisi identik dengan Launch Screen.
class KamaimoLogoIcon extends StatelessWidget {
  final double size;
  final double padding;
  final double borderRadius;
  final Color backgroundColor;

  const KamaimoLogoIcon({
    super.key,
    this.size = 38,
    this.padding = 6.5,
    this.borderRadius = 8.5,
    this.backgroundColor = const Color(0xFF35644A),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: const CustomPaint(
        painter: KamaimoEmblemPainter(),
      ),
    );
  }
}

/// CustomPainter emblem Berani Kamaimo.
class KamaimoEmblemPainter extends CustomPainter {
  const KamaimoEmblemPainter();

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
