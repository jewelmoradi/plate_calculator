import 'package:flutter/material.dart';
import 'package:plate_calculator/services/api_service.dart';
import 'dart:convert';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<dynamic>> _mealsFuture;

  @override
  void initState() {
    super.initState();
    _mealsFuture = ApiService.getMeals();
  }

  Future<void> _refresh() async {
    final newMeals = ApiService.getMeals();
    setState(() {
      _mealsFuture = newMeals;
    });
    await newMeals;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meal History')),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<dynamic>>(
          future: _mealsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No meals logged yet.'));
            }
            final meals = snapshot.data ?? const [];

            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];

                Widget leading;
                final imageData = meal['imageData'];
                if (imageData is String && imageData.startsWith('data:image')) {
                  try {
                    final bytes = base64Decode(imageData.split(',').last);
                    leading = Image.memory(
                      bytes,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    );
                  } catch (_) {
                    leading = const Icon(Icons.broken_image);
                  }
                } else {
                  leading = const Icon(Icons.fastfood);
                }

                String subtitle = '';
                final ts = meal['timestamp'];
                if (ts is String) {
                  final dt = DateTime.tryParse(ts)?.toLocal();
                  subtitle = dt?.toString() ?? ts;
                }

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: leading,
                    title: Text(meal['aiResponse'] ?? 'No response'),
                    subtitle: Text(subtitle),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
