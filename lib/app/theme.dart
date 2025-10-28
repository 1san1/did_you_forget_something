import 'package:flutter/material.dart';

ThemeData buildLightTheme() {
  const seedColor = Color(0xFF5C6BC0);
  final colorScheme = ColorScheme.fromSeed(seedColor: seedColor);

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: colorScheme.onSurface,
      ),
    ),
    textTheme: _buildTextTheme(colorScheme),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}

ThemeData buildDarkTheme() {
  const seedColor = Color(0xFF5C6BC0);
  final colorScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.dark,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: colorScheme.onSurface,
      ),
    ),
    textTheme: _buildTextTheme(colorScheme),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}

TextTheme _buildTextTheme(ColorScheme colorScheme) {
  return TextTheme(
    headlineLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: colorScheme.onBackground,
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w600,
      color: colorScheme.onBackground,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w600,
      color: colorScheme.onBackground,
    ),
    bodyLarge: TextStyle(
      color: colorScheme.onBackground,
    ),
    bodyMedium: TextStyle(
      color: colorScheme.onBackground.withOpacity(0.8),
    ),
    labelLarge: TextStyle(
      fontWeight: FontWeight.w600,
      color: colorScheme.onPrimary,
    ),
  );
}
