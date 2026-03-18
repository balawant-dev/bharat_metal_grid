// import 'dart:math';
// import 'package:flutter/material.dart';
//
// class AppLoader extends StatefulWidget {
//   final double size;
//
//   const AppLoader({super.key, this.size = 48});
//
//   @override
//   State<AppLoader> createState() => _AppLoaderState();
// }
//
// class _AppLoaderState extends State<AppLoader>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: widget.size,
//       height: widget.size,
//       child: AnimatedBuilder(
//         animation: _controller,
//         builder: (_, __) {
//           return CustomPaint(
//             painter: _LoaderPainter(_controller.value),
//           );
//         },
//       ),
//     );
//   }
// }
// class _LoaderPainter extends CustomPainter {
//   final double progress;
//
//   _LoaderPainter(this.progress);
//
//   final Color primary = const Color(0xFF022976);
//   final Color secondary = const Color(0xFF2F61C3);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = size.center(Offset.zero);
//     final radius = size.width / 2;
//
//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;
//
//     // 🔵 Outer Arc (Primary)
//     paint
//       ..color = primary
//       ..strokeWidth = 4;
//
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius - 2),
//       progress * 2 * pi,
//       pi * 1.2,
//       false,
//       paint,
//     );
//
//     // 🔹 Inner Arc (Secondary)
//     paint
//       ..color = secondary
//       ..strokeWidth = 3;
//
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius - 10),
//       -progress * 2 * pi,
//       pi * 0.8,
//       false,
//       paint,
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }


import 'dart:math';
import 'package:flutter/material.dart';

class AppMetalLoader extends StatefulWidget {
  final double size;
  final String? text;

  const AppMetalLoader({
    super.key,
    this.size = 90,
    this.text,
  });

  @override
  State<AppMetalLoader> createState() => _AppMetalLoaderState();
}

class _AppMetalLoaderState extends State<AppMetalLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: widget.size,
          height: widget.size,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return CustomPaint(
                painter: _MetalGearPainter(_controller.value),
              );
            },
          ),
        ),
        if (widget.text != null) ...[
          const SizedBox(height: 12),
          Text(
            widget.text!,
            style: const TextStyle(
              fontSize: 13,
              letterSpacing: 0.8,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }
}

/// 🎨 Painter
class _MetalGearPainter extends CustomPainter {
  final double progress;
  _MetalGearPainter(this.progress);

  final Color darkMetal = const Color(0xFF022976);
  final Color lightMetal = const Color(0xFF2F61C3);
  final Color boltColor = const Color(0xFF9FA8DA);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    /// 🔵 Outer Metal Ring
    paint
      ..strokeWidth = 5
      ..shader = SweepGradient(
        colors: [darkMetal, lightMetal, darkMetal],
        startAngle: 0,
        endAngle: 2 * pi,
        transform: GradientRotation(progress * 2 * pi),
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius - 4, paint);

    /// ⚙️ Gear Teeth
    paint
      ..shader = null
      ..color = darkMetal
      ..strokeWidth = 3;

    for (int i = 0; i < 8; i++) {
      final angle = (2 * pi / 8) * i + progress * 2 * pi;
      final start = Offset(
        center.dx + cos(angle) * (radius - 10),
        center.dy + sin(angle) * (radius - 10),
      );
      final end = Offset(
        center.dx + cos(angle) * (radius - 2),
        center.dy + sin(angle) * (radius - 2),
      );
      canvas.drawLine(start, end, paint);
    }

    /// 🔩 Inner Bolts (Rotating opposite)
    paint
      ..strokeWidth = 4
      ..color = boltColor;

    for (int i = 0; i < 3; i++) {
      final angle = (2 * pi / 3) * i - progress * 2 * pi;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - 22),
        angle,
        pi / 5,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
