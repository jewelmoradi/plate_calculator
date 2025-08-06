import 'package:flutter/material.dart';
import 'package:plate_calculator/screens/gallery_screen.dart';
import 'package:plate_calculator/screens/camera_screen.dart';

class LogMealScreen extends StatelessWidget {
  const LogMealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Meal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'How would you like to log your meal?',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text('Take a Photo'),
              onPressed: () {
                Navigator.pushNamed(context, '/log-meal/camera');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              icon: const Icon(Icons.photo_library),
              label: const Text('Choose from Gallery'),
              onPressed: () {
                Navigator.pushNamed(context, '/log-meal/gallery');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
