import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class SlashEffect extends StatefulWidget {
  final VoidCallback onComplete;

  const SlashEffect({super.key, required this.onComplete});

  @override
  State<SlashEffect> createState() => _SlashEffectState();
}

class _SlashEffectState extends State<SlashEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _progress = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _controller.forward().then((_) {
      if (mounted) widget.onComplete();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(100, 100),
          painter: _SlashPainter(progress: _progress.value),
        );
      },
    );
  }
}

class _SlashPainter extends CustomPainter {
  final double progress;

  _SlashPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0 || progress == 1) return;

    final paint = Paint()
      ..color = AppColors.accent
      ..strokeWidth = 4 + (1 - progress) * 6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 4);

    final path = Path();
    
    // Calculate slash coordinates
    final startX = size.width * 0.8;
    final startY = size.height * 0.2;
    final endX = size.width * 0.2;
    final endY = size.height * 0.8;

    final currentX = startX + (endX - startX) * progress;
    final currentY = startY + (endY - startY) * progress;

    path.moveTo(startX, startY);
    path.lineTo(currentX, currentY);

    canvas.drawPath(path, paint);

    // Inner bright core
    final corePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2 + (1 - progress) * 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
      
    canvas.drawPath(path, corePaint);
  }

  @override
  bool shouldRepaint(_SlashPainter oldDelegate) => progress != oldDelegate.progress;
}
