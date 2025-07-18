import 'package:flutter/material.dart';
import './gallery_screen.dart';
import './camera_screen.dart';

void main() {
  runApp(MyApp());
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
        home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void openGallery(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GalleryScreen()),
    );
  }

  void openCamera(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plate Calculator')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 20),
              ),
              onPressed: () => openGallery(context),
              child: const Text('Select from gallery'),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 20),
              ),
              onPressed: () => openCamera(context),
              child: const Text('Take picture'),
            ),
          ],
        ),
      ),
    );
  }
}
