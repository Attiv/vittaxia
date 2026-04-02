import 'package:flutter/material.dart';

class FloatingDamageText extends StatefulWidget {
  final String text;
  final Color color;
  final VoidCallback onComplete;

  const FloatingDamageText({
    super.key,
    required this.text,
    required this.color,
    required this.onComplete,
  });

  @override
  State<FloatingDamageText> createState() => _FloatingDamageTextState();
}

class _FloatingDamageTextState extends State<FloatingDamageText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _dyAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _dyAnimation = Tween<double>(begin: 0, end: -60).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 30),
    ]).animate(_controller);

    _controller.forward().then((_) {
      if (mounted) {
        widget.onComplete();
      }
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
        return Transform.translate(
          offset: Offset(0, _dyAnimation.value),
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: widget.color,
                shadows: const [
                  Shadow(
                    blurRadius: 4.0,
                    color: Colors.black87,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DamageNumber {
  final String id;
  final String text;
  final Color color;

  DamageNumber({
    required this.id,
    required this.text,
    required this.color,
  });
}
