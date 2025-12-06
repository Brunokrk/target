import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Cores primárias 
  static const Color primary = Color(0xFF3A8A8A);
  static const Color primaryLight = Color(0xFF4ECACA);
  static const Color primaryDark = Color(0xFF2D5F5F);

  // Cores de gradiente
  static const List<Color> gradientColors = [
    Color(0xFF2D5F5F),
    Color(0xFF3A8A8A),
    Color(0xFF4ECACA),
  ];

  // Cores de ações
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Cores de estatísticas
  static const Color statItems = Color(0xFF2196F3);
  static const Color statEdits = Color(0xFFFF9800);
  static const Color statCharacters = Color(0xFF4CAF50);
  static const Color statLetters = Color(0xFF2196F3);
  static const Color statNumbers = Color(0xFF4CAF50);

  // Cores neutras
  static const Color background = Colors.white;
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color divider = Color(0xFFE0E0E0);

  // Cores de texto sobre fundo claro
  static const Color textOnLight = Color(0xFF212121);
  static const Color textSecondaryOnLight = Color(0xFF757575);

  // Cores de texto sobre fundo escuro/gradiente
  static const Color textOnDark = Colors.white;
  static const Color textSecondaryOnDark = Color(0xE6FFFFFF);

  // Cores de AppBar
  static const Color appBarBackground = Color(0xFF3A8A8A);
  static const Color appBarIcon = Colors.white;

  // Cores de Bottom Navigation
  static const Color bottomNavSelected = Color(0xFF2D5F5F);
  static const Color bottomNavUnselected = Color(0xFF757575);
  static const Color bottomNavBackground = Colors.white;

  // Cores de FloatingActionButton
  static const Color fabBackground = Colors.white;
  static const Color fabIcon = Color(0xFF3A8A8A);

  // Cores de Card
  static const Color cardBackground = Colors.white;
  static const Color cardElevation = Color(0x1F000000);

  // Cores de ícones selecionados
  static const Color iconSelectedBackground = Color(0xFFE0F7F7);
  static const Color iconSelectedBorder = Color(0xFF4ECACA);
  static const Color iconSelected = Color(0xFF2D5F5F);
  static const Color iconUnselectedBackground = Color(0xFFF5F5F5);
  static const Color iconUnselected = Color(0xFF757575);

  // Cores de progress bar
  static const Color progressBackground = Color(0xFFE0E0E0);
  static const Color progressLetters = Color(0xFF2196F3);
  static const Color progressNumbers = Color(0xFF4CAF50);

  // Cores de legend
  static const Color legendBackground = Color(0xFFFAFAFA);
  static const Color legendDivider = Color(0xFFE0E0E0);

  /// Cria o ThemeData do aplicativo
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        secondary: primaryLight,
        background: background,
        error: error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimary,
        onBackground: textPrimary,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: appBarBackground,
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: appBarIcon),
      ),
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: fabBackground,
        foregroundColor: fabIcon,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: bottomNavBackground,
        selectedItemColor: bottomNavSelected,
        unselectedItemColor: bottomNavUnselected,
        type: BottomNavigationBarType.fixed,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryLight, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: error, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: primaryDark,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        displaySmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: textSecondary,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: textSecondary,
        ),
      ),
    );
  }
}

