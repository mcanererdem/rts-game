import 'package:flutter/material.dart';
import '../../data/local/preferences_service.dart';

enum AppThemeMode {
  light,
  dark,
  colorful;
}

class ThemeProvider extends ChangeNotifier {
  static final ThemeProvider _instance = ThemeProvider._internal();
  factory ThemeProvider() => _instance;
  ThemeProvider._internal();

  AppThemeMode _themeMode = AppThemeMode.light;

  AppThemeMode get themeMode => _themeMode;

  Future<void> loadTheme() async {
    final themeIndex = PreferencesService.instance.getInt('theme_mode') ?? 0;
    _themeMode = AppThemeMode.values[themeIndex];
    notifyListeners();
  }

  Future<void> setTheme(AppThemeMode mode) async {
    _themeMode = mode;
    await PreferencesService.instance.setInt('theme_mode', mode.index);
    notifyListeners();
  }

  ThemeData getTheme() {
    switch (_themeMode) {
      case AppThemeMode.light:
        return _buildLightTheme();
      case AppThemeMode.dark:
        return _buildDarkTheme();
      case AppThemeMode.colorful:
        return _buildColorfulTheme();
    }
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF667EEA),
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF667EEA),
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF667EEA),
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Color(0xFF212121),
        ),
        displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color(0xFF212121),
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Color(0xFF212121),
        ),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF764BA2),
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF764BA2),
        foregroundColor: Colors.white,
        elevation: 6,
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1E1E1E),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF764BA2),
          foregroundColor: Colors.white,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
    );
  }

  ThemeData _buildColorfulTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFFF6B6B),
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFFFF0F0),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFF6B6B),
        foregroundColor: Colors.white,
        elevation: 5,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF6B6B),
          foregroundColor: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Color(0xFF212121),
        ),
        displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color(0xFF212121),
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Color(0xFF212121),
        ),
      ),
    );
  }

  String getThemeDisplayName() {
    switch (_themeMode) {
      case AppThemeMode.light:
        return 'Açık Tema';
      case AppThemeMode.dark:
        return 'Koyu Tema';
      case AppThemeMode.colorful:
        return 'Renkli Tema';
    }
  }

  String getThemeDescription() {
    switch (_themeMode) {
      case AppThemeMode.light:
        return 'Modern ve parlak tasarım';
      case AppThemeMode.dark:
        return 'Göz yorucu olmayan koyu tasarım';
      case AppThemeMode.colorful:
        return 'Enerjik ve canlı renkler';
    }
  }
}
