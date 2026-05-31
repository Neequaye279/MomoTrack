import 'package:flutter/material.dart';

class GraphPainter extends CustomPainter {
  final Color color;

  GraphPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    // ===== SHARP TREND WITH DOWNWARD LEFT BREAK =====
    final points = [
      Offset(0, size.height * 0.78), // 👈 starts lower (downward break)
      Offset(size.width * 0.12, size.height * 0.62),
      Offset(size.width * 0.28, size.height * 0.72),
      Offset(size.width * 0.42, size.height * 0.40),
      Offset(size.width * 0.58, size.height * 0.55),
      Offset(size.width * 0.72, size.height * 0.25),
      Offset(size.width * 0.86, size.height * 0.38),
      Offset(size.width, size.height * 0.18),
    ];

    // ===== SHARP LINE =====
    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    // ===== FADE FILL (TOP STRONG → BOTTOM WEAK + LEFT DISAPPEAR) =====
    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withValues(alpha: 0.14), // strong at top
          color.withValues(alpha: 0.04), // fades downward
          color.withValues(alpha: 0.01), // almost gone
        ],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // extra LEFT fade mask
    final leftFade = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [
          Colors.transparent,
          Colors.transparent,
          color.withValues(alpha: 0.05),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(fillPath, leftFade);

    // ===== MAIN LINE (SHARP) =====
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..strokeWidth = 2.2
        ..style = PaintingStyle.stroke
        ..strokeJoin = StrokeJoin.miter
        ..strokeCap = StrokeCap.butt,
    );

    // ===== SUBTLE GLOW =====
    canvas.drawPath(
      path,
      Paint()
        ..color = color.withValues(alpha: 0.10)
        ..strokeWidth = 6
        ..style = PaintingStyle.stroke
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );

    // ===== END DOT =====
    final end = points.last;

    canvas.drawCircle(end, 8, Paint()..color = color.withValues(alpha: 0.18));

    canvas.drawCircle(end, 3.5, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
