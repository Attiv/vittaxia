import 'package:flutter/material.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class VittaxiaApp extends StatelessWidget {
  const VittaxiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '侠',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: appRouter,
    );
  }
}
