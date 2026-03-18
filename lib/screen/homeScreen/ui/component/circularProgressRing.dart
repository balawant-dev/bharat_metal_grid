// import 'dart:math';
// import 'package:flutter/material.dart';
//
// class CircleProgressRingScreen extends StatelessWidget {
//   const CircleProgressRingScreen({super.key});
//
//   final double progress = 0.75; // 65 days example (0.0 - 1.0)
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: CustomPaint(
//         size: const Size(220, 220),
//         painter: CircleProgressPainter(progress),
//         child: const SizedBox(
//           width: 160,
//           height: 160,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Membership\nexpiring in",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.white70,
//                   fontSize: 12,
//                 ),
//               ),
//               SizedBox(height: 6),
//               Text(
//                 "65 Days left",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// class CircleProgressPainter extends CustomPainter {
//   final double progress;
//
//   CircleProgressPainter(this.progress);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = size.center(Offset.zero);
//     final radius = size.width / 2 - 12;
//
//     /// Background circle
//     final bgPaint = Paint()
//       ..color = Colors.white.withOpacity(0.15)
//       ..strokeWidth = 12
//       ..style = PaintingStyle.stroke;
//
//     /// Progress circle
//     final progressPaint = Paint()
//       ..color = Colors.white
//       ..strokeWidth = 12
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;
//
//     canvas.drawCircle(center, radius, bgPaint);
//
//     final sweepAngle = 2 * pi * progress;
//
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       -pi / 2,
//       sweepAngle,
//       false,
//       progressPaint,
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }

import 'dart:math';
import 'package:flutter/material.dart';

class CircleProgressRingScreen extends StatefulWidget {
  const CircleProgressRingScreen({super.key});

  @override
  State<CircleProgressRingScreen> createState() =>
      _CircleProgressRingScreenState();
}


class _CircleProgressRingScreenState extends State<CircleProgressRingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final double targetProgress = 0.7;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: targetProgress,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward(); // animation start
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            size: const Size(220, 220),
            painter: CircleProgressPainter(_animation.value),
            child: const SizedBox(
              width: 160,
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Membership\nexpiring in",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "65 Days left",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
class CircleProgressPainter extends CustomPainter {
  final double progress;

  CircleProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - 12;

    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke;

    final progressPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    final sweepAngle = 2 * pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CircleProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
