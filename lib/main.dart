import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gemini_app/config/constants/enviroment.dart';
import 'package:gemini_app/config/theme/app_theme.dart';
import 'config/router/app_router.dart';

Future<void> main() async {
  AppTheme.setSystemUIOverlayStyle(isDarkmode: true);
  await Environment.initEnvironment();

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
