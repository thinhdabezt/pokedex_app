import 'package:flutter/material.dart';

class AppTheme {
  // Pokedex color palette
  static const Color pokedexRed = Color(0xFFCC0000);
  static const Color pokedexDarkRed = Color(0xFF990000);
  static const Color pokedexWhite = Color(0xFFFAFAFA);
  static const Color pokedexBlack = Color(0xFF1A1A1A);
  static const Color pokedexGray = Color(0xFF666666);
  static const Color pokedexLightGray = Color(0xFFE0E0E0);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: _createMaterialColor(pokedexRed),
    primaryColor: pokedexRed,
    scaffoldBackgroundColor: pokedexWhite,
    
    // Pixel-style font
    fontFamily: 'monospace',
    
    // AppBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: pokedexRed,
      foregroundColor: pokedexWhite,
      elevation: 4,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'monospace',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: pokedexWhite,
      ),
      iconTheme: IconThemeData(
        color: pokedexWhite,
        size: 24,
      ),
    ),
    
    // Card theme
    cardTheme: CardThemeData(
      color: pokedexWhite,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: pokedexBlack, width: 2),
      ),
      margin: const EdgeInsets.all(8),
    ),
    
    // List tile theme
    listTileTheme: const ListTileThemeData(
      textColor: pokedexBlack,
      iconColor: pokedexRed,
      tileColor: pokedexWhite,
      selectedTileColor: pokedexLightGray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    
    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: pokedexBlack, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: pokedexGray, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: pokedexRed, width: 2),
      ),
      fillColor: pokedexWhite,
      filled: true,
      hintStyle: const TextStyle(
        color: pokedexGray,
        fontFamily: 'monospace',
      ),
      labelStyle: const TextStyle(
        color: pokedexBlack,
        fontFamily: 'monospace',
        fontWeight: FontWeight.bold,
      ),
    ),
    
    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: pokedexRed,
        foregroundColor: pokedexWhite,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: pokedexBlack, width: 2),
        ),
        textStyle: const TextStyle(
          fontFamily: 'monospace',
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    
    // Text theme
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'monospace',
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: pokedexBlack,
      ),
      displayMedium: TextStyle(
        fontFamily: 'monospace',
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: pokedexBlack,
      ),
      displaySmall: TextStyle(
        fontFamily: 'monospace',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: pokedexBlack,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'monospace',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: pokedexBlack,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'monospace',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: pokedexBlack,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'monospace',
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: pokedexBlack,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'monospace',
        fontSize: 16,
        color: pokedexBlack,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'monospace',
        fontSize: 14,
        color: pokedexBlack,
      ),
      bodySmall: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: pokedexGray,
      ),
    ),
    
    // Icon theme
    iconTheme: const IconThemeData(
      color: pokedexRed,
      size: 24,
    ),
    
    // Progress indicator theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: pokedexRed,
      linearTrackColor: pokedexLightGray,
      circularTrackColor: pokedexLightGray,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: _createMaterialColor(pokedexRed),
    primaryColor: pokedexRed,
    scaffoldBackgroundColor: pokedexBlack,
    
    // Pixel-style font
    fontFamily: 'monospace',
    
    // AppBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: pokedexBlack,
      foregroundColor: pokedexWhite,
      elevation: 4,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'monospace',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: pokedexWhite,
      ),
      iconTheme: IconThemeData(
        color: pokedexWhite,
        size: 24,
      ),
    ),
    
    // Card theme
    cardTheme: CardThemeData(
      color: const Color(0xFF2A2A2A),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: pokedexRed, width: 2),
      ),
      margin: const EdgeInsets.all(8),
    ),
    
    // List tile theme
    listTileTheme: const ListTileThemeData(
      textColor: pokedexWhite,
      iconColor: pokedexRed,
      tileColor: Color(0xFF2A2A2A),
      selectedTileColor: Color(0xFF3A3A3A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    
    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: pokedexRed, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: pokedexGray, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: pokedexRed, width: 2),
      ),
      fillColor: const Color(0xFF2A2A2A),
      filled: true,
      hintStyle: const TextStyle(
        color: pokedexGray,
        fontFamily: 'monospace',
      ),
      labelStyle: const TextStyle(
        color: pokedexWhite,
        fontFamily: 'monospace',
        fontWeight: FontWeight.bold,
      ),
    ),
    
    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: pokedexRed,
        foregroundColor: pokedexWhite,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: pokedexWhite, width: 2),
        ),
        textStyle: const TextStyle(
          fontFamily: 'monospace',
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    
    // Text theme
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'monospace',
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: pokedexWhite,
      ),
      displayMedium: TextStyle(
        fontFamily: 'monospace',
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: pokedexWhite,
      ),
      displaySmall: TextStyle(
        fontFamily: 'monospace',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: pokedexWhite,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'monospace',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: pokedexWhite,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'monospace',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: pokedexWhite,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'monospace',
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: pokedexWhite,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'monospace',
        fontSize: 16,
        color: pokedexWhite,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'monospace',
        fontSize: 14,
        color: pokedexWhite,
      ),
      bodySmall: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: pokedexGray,
      ),
    ),
    
    // Icon theme
    iconTheme: const IconThemeData(
      color: pokedexRed,
      size: 24,
    ),
    
    // Progress indicator theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: pokedexRed,
      linearTrackColor: pokedexGray,
      circularTrackColor: pokedexGray,
    ),
  );

  static MaterialColor _createMaterialColor(Color color) {
    final List<double> strengths = <double>[.05];
    final Map<int, Color> swatch = <int, Color>{};
    final int r = (color.r * 255.0).round(), g = (color.g * 255.0).round(), b = (color.b * 255.0).round();

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    
    for (final double strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    
    return MaterialColor(color.value, swatch);
  }
}
