import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const seedColor = Color(0xFF1E1C36);

class AppTheme {
  final bool isDarkmode;

  AppTheme({required this.isDarkmode});

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: seedColor,
    brightness: isDarkmode ? Brightness.dark : Brightness.light,

    listTileTheme: const ListTileThemeData(iconColor: seedColor),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1C36),
      surfaceTintColor: Colors.transparent,
    ),
  );

  /// Configura la barra de estado y navegación del sistema
  static setSystemUIOverlayStyle({required bool isDarkmode}) {
    /**
     Este método configura la apariencia de las barras del sistema operativo 
     (barra de estado superior y barra de navegación inferior):
        Ajusta el brillo de los iconos según el tema
        Hace las barras transparentes
        Mantiene consistencia visual entre la app y la UI del sistema
    */
    final themeBrightness = isDarkmode ? Brightness.dark : Brightness.light;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: themeBrightness,
        statusBarIconBrightness: themeBrightness,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: themeBrightness,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
  }
}
