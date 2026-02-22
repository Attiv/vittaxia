import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/theme/theme_settings.dart';
import 'core/utils/game_audio.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeSettings.ensureInitialized();
  await GameAudio.ensureInitialized();
  runApp(const ProviderScope(child: VittaxiaApp()));
}
