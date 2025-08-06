import 'package:flutter/material.dart';
import 'package:plate_calculator/screens/log-meal-screen.dart';
import 'package:plate_calculator/screens/main_menu_screen.dart';
import 'package:plate_calculator/screens/gallery_screen.dart';
import 'package:plate_calculator/screens/camera_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plate Calculator',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Color(0xFFFFF3EE),
        primaryColor: Color(0xFFFFA585),
        colorScheme: ColorScheme.light(
          primary: Color(0xFFFFA585),
          secondary: Color(0xFFFFEB85),
          surface: Color(0xFFFFF3EE),
          error: Color(0xFF9E2B25),
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Color(0xFF3D3E3E),
          onError: Colors.white,
          ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFFFA585),
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF3D3E3E)),
          bodyMedium: TextStyle(color: Color(0xFF3D3E3E)),
          titleLarge: TextStyle(color: Color(0xFF3D3E3E), fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFFA585),
            foregroundColor: Colors.white,
            textStyle: TextStyle(fontSize: 16),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Color(0xFFFFA585),
          contentTextStyle: TextStyle(color: Colors.white),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainMenuScreen(),
        '/log-meal': (context) => const LogMealScreen(),
        '/log-meal/gallery': (context) => const GalleryScreen(),
        '/log-meal/camera': (context) => const CameraScreen(),
        //'/history': (context) => const HistoryScreen(),
        // '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
