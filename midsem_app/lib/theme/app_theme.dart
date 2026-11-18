// =============================================================================
// C1 (6 marks) — Theme
//
// 1. Set primary and secondary to YOUR variant's colours (exam paper table).
// 2. Build light() with ColorScheme.fromSeed(seedColor: primary, ...),
//    useMaterial3: true, an AppBarTheme (primary background, white text)
//    and an ElevatedButtonThemeData (secondary background).
// 3. fontSize: must not appear anywhere in lib/screens/ — use
//    Theme.of(context).textTheme roles (titleMedium, bodySmall, ...).
// =============================================================================
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF1565C0);
  static const Color secondary = Color(0xFFFFA000);

  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: secondary,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: secondary,
          foregroundColor: Colors.black,
        ),
      ),
      cardTheme: CardThemeData(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
      ),
    );
  }
}

/// Screen widths (logical pixels) where the layout changes.
class Breakpoints {
  static const double tablet = 600;
}
