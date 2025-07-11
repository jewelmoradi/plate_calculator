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
