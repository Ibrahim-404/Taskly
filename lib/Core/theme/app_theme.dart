import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color _primaryLight = Color(0xFF007AFF);
  static const Color _primaryDark = Color(0xFF0A84FF);
  static const Color _secondaryLight = Color(0xFF6A11CB);
  static const Color _secondaryDark = Color(0xFF9B59E0);

  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 20;
  static const double radiusXxl = 24;

  static const double spaceXs = 4;
  static const double spaceSm = 8;
  static const double spaceMd = 16;
  static const double spaceLg = 24;
  static const double spaceXl = 32;

  static ThemeData light() {
    final colorScheme = ColorScheme.light(
      primary: _primaryLight,
      secondary: _secondaryLight,
      surface: Colors.white,
      surfaceContainerLow: Color(0xFFF5F5F7),
      surfaceContainerHighest: Color(0xFFE8E8ED),
      onSurface: Color(0xFF1C1C1E),
      onSurfaceVariant: Color(0xFF6E6E73),
      outlineVariant: Color(0xFFD1D1D6),
      shadow: Color(0xFF000000),
    );
    return _buildTheme(colorScheme, Brightness.light);
  }

  static ThemeData dark() {
    final colorScheme = ColorScheme.dark(
      primary: _primaryDark,
      secondary: _secondaryDark,
      surface: Color(0xFF000000),
      surfaceContainerLow: Color(0xFF1C1C1E),
      surfaceContainerHighest: Color(0xFF2C2C2E),
      onSurface: Color(0xFFF2F2F7),
      onSurfaceVariant: Color(0xFF8E8E93),
      outlineVariant: Color(0xFF3A3A3C),
      shadow: Color(0xFF000000),
    );
    return _buildTheme(colorScheme, Brightness.dark);
  }

  static ThemeData _buildTheme(ColorScheme cs, Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      brightness: brightness,
      textTheme: _textTheme(cs),
      appBarTheme: AppBarTheme(
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: cs.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        color: cs.surface,
        elevation: 0,
        shadowColor: cs.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusXxl),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cs.surfaceContainerHighest.withValues(alpha: 0.5),
        hintStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusXl),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusXl),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusXl),
          borderSide: BorderSide(color: cs.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        prefixIconColor: cs.onSurfaceVariant,
        suffixIconColor: cs.onSurfaceVariant,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: cs.surfaceContainerHighest.withValues(alpha: 0.5),
        selectedColor: cs.primary,
        labelStyle: TextStyle(color: cs.onSurface, fontSize: 13),
        secondaryLabelStyle: TextStyle(color: cs.onPrimary, fontSize: 13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusXl),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cs.surface,
        indicatorColor: cs.primary.withValues(alpha: 0.15),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: cs.primary, size: 24);
          }
          return IconThemeData(color: cs.onSurfaceVariant, size: 24);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: cs.primary);
          }
          return TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: cs.onSurfaceVariant);
        }),
        height: 65,
        elevation: 1,
        shadowColor: cs.shadow,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          minimumSize: const Size.fromHeight(54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusXl),
          ),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: cs.onPrimary,
          ),
          elevation: 0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: cs.primary,
          textStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: cs.outlineVariant,
        thickness: 0.5,
        space: 1,
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return cs.primary;
          return Colors.transparent;
        }),
        side: BorderSide(color: cs.onSurfaceVariant, width: 1.5),
      ),
      extensions: const [],
    );
  }

  static TextTheme _textTheme(ColorScheme cs) {
    return TextTheme(
      displayLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: cs.onSurface, letterSpacing: -0.5),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: cs.onSurface, letterSpacing: -0.5),
      displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: cs.onSurface, letterSpacing: -0.3),
      headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: cs.onSurface, letterSpacing: -0.3),
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: cs.onSurface, letterSpacing: -0.3),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: cs.onSurface),
      titleLarge: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: cs.onSurface),
      titleMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: cs.onSurface),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: cs.onSurfaceVariant),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: cs.onSurface),
      bodyMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: cs.onSurface),
      bodySmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: cs.onSurfaceVariant),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: cs.onSurface),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: cs.onSurfaceVariant),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: cs.onSurfaceVariant),
    );
  }

  static List<Color> headerGradient(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (isDark) {
      return [c.surfaceContainerLow, c.surfaceContainerHighest];
    }
    return [c.primary, c.secondary];
  }

  static List<Color> navBarGradient(BuildContext context) {
    return headerGradient(context);
  }

  static List<Color> buttonGradient(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (isDark) {
      return [c.primary.withValues(alpha: 0.8), c.secondary.withValues(alpha: 0.8)];
    }
    return [c.primary, c.secondary];
  }
}
