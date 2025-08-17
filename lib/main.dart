import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_app/config/theme/app_theme.dart';

import 'config/router/app_router.dart';

void main() {
  AppTheme.setSystemUIOverlayStyle(isDarkmode: true);

  runApp(ProviderScope(child: const GeminiApp()));
}

class GeminiApp extends StatelessWidget {
  const GeminiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(isDarkmode: true).getTheme(),
    );
  }
}
