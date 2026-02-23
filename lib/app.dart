import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_settings.dart';

class VittaxiaApp extends StatelessWidget {
  const VittaxiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UiThemePreset>(
      valueListenable: ThemeSettings.listenable,
      builder: (context, preset, _) {
        final spec =
            uiThemeSpecs[preset] ?? uiThemeSpecs[UiThemePreset.warmInk]!;
        AppColors.apply(spec);

        return MaterialApp.router(
          title: '侠',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.buildTheme(spec),
          routerConfig: appRouter,
          locale: const Locale('zh', 'CN'),
          supportedLocales: const [Locale('zh', 'CN')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          scrollBehavior: const _NoGlowScrollBehavior(),
          builder: (context, child) {
            final content = child ?? const SizedBox.shrink();

            return DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: spec.backgroundGradient,
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  IgnorePointer(
                    child: CustomPaint(painter: _InkTexturePainter(spec)),
                  ),
                  content,
                  if (spec.uiTintOpacity > 0)
                    IgnorePointer(
                      child: ColoredBox(
                        color: spec.uiTintColor.withValues(
                          alpha: spec.uiTintOpacity * 0.36,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _NoGlowScrollBehavior extends MaterialScrollBehavior {
  const _NoGlowScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}

class _InkTexturePainter extends CustomPainter {
  final UiThemeSpec spec;

  const _InkTexturePainter(this.spec);

  @override
  void paint(Canvas canvas, Size size) {
    final softCloud = Paint()
      ..style = PaintingStyle.fill
      ..color = spec.textureCloud;
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = spec.textureRing;
    final dust = Paint()
      ..style = PaintingStyle.fill
      ..color = spec.textureDust;

    // 大面积墨晕
    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.18),
      size.shortestSide * 0.42,
      softCloud,
    );
    canvas.drawCircle(
      Offset(size.width * 0.88, size.height * 0.84),
      size.shortestSide * 0.36,
      softCloud,
    );

    // 细环纹理
    for (var i = 0; i < 5; i++) {
      final t = i / 4;
      canvas.drawCircle(
        Offset(size.width * 0.24, size.height * 0.78),
        size.shortestSide * (0.10 + t * 0.08),
        ring,
      );
    }
    for (var i = 0; i < 4; i++) {
      final t = i / 3;
      canvas.drawCircle(
        Offset(size.width * 0.82, size.height * 0.22),
        size.shortestSide * (0.08 + t * 0.06),
        ring,
      );
    }

    // 细碎金尘
    final w = size.width;
    final h = size.height;
    for (var i = 0; i < 40; i++) {
      final fx = (i * 37 % 100) / 100;
      final fy = (i * 53 % 100) / 100;
      final r = 0.8 + (i % 3) * 0.5;
      canvas.drawCircle(Offset(w * fx, h * fy), r, dust);
    }

    // 左上角微弧笔触
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2
      ..color = spec.textureStroke;
    final path = Path();
    path.moveTo(size.width * 0.05, size.height * 0.10);
    path.cubicTo(
      size.width * 0.22,
      size.height * 0.02,
      size.width * 0.35,
      size.height * 0.16,
      size.width * 0.52,
      size.height * 0.08,
    );
    canvas.drawPath(path, stroke);

    // 右下角笔触
    final path2 = Path();
    path2.moveTo(size.width * 0.52, size.height * 0.92);
    path2.quadraticBezierTo(
      size.width * 0.72,
      size.height * 0.84,
      size.width * 0.94,
      size.height * 0.94,
    );
    canvas.drawPath(path2, stroke);

    // 中间淡斜纹
    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = spec.textureLine;
    for (var i = -6; i < 10; i++) {
      final y = size.height * 0.16 + i * 44;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y + size.width * 0.08),
        line,
      );
    }

    // 角落微旋纹
    final swirl = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = spec.textureSwirl;
    final center = Offset(size.width * 0.12, size.height * 0.9);
    for (var i = 0; i < 22; i++) {
      final a0 = i * 0.24;
      final a1 = a0 + 0.18;
      final r0 = 8 + i * 2.6;
      final r1 = r0 + 5;
      final p0 = center + Offset(math.cos(a0) * r0, math.sin(a0) * r0);
      final p1 = center + Offset(math.cos(a1) * r1, math.sin(a1) * r1);
      canvas.drawLine(p0, p1, swirl);
    }
  }

  @override
  bool shouldRepaint(covariant _InkTexturePainter oldDelegate) {
    return oldDelegate.spec.id != spec.id;
  }
}
