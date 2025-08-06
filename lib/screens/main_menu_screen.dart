import 'package:flutter/material.dart';
import 'package:plate_calculator/screens/log-meal-screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text('Plate Calculator'),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildMenuButton(
                context,
                label: 'Log Meal',
                onPressed: () {
                  Navigator.pushNamed(context, '/log-meal');
                },
              ),
              const SizedBox(height: 20),
              _buildMenuButton(
                context,
                label: 'History',
                onPressed: () {
                  Navigator.pushNamed(context, '/history');
                },
              ),
              const SizedBox(height: 20),
              _buildMenuButton(
                context,
                label: 'Settings',
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildMenuButton(BuildContext context, {required String label, required VoidCallback onPressed}) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(12), 
          ),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
