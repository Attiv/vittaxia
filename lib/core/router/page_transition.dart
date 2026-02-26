import 'package:flutter/material.dart';

Route<T> buildSmoothPageRoute<T>({
  required Widget page,
  RouteSettings? settings,
}) {
  return PageRouteBuilder<T>(
    settings: settings,
    transitionDuration: const Duration(milliseconds: 240),
    reverseTransitionDuration: const Duration(milliseconds: 180),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final fade = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      final slide = Tween<Offset>(
        begin: const Offset(0.05, 0.02),
        end: Offset.zero,
      ).animate(fade);
      return FadeTransition(
        opacity: fade,
        child: SlideTransition(position: slide, child: child),
      );
    },
  );
}

Future<T?> pushSmoothPage<T>(BuildContext context, Widget page) {
  return Navigator.of(context).push<T>(buildSmoothPageRoute<T>(page: page));
}

Future<T?> pushSmoothReplacementPage<T, TO>(BuildContext context, Widget page) {
  return Navigator.of(
    context,
  ).pushReplacement<T, TO>(buildSmoothPageRoute<T>(page: page));
}
