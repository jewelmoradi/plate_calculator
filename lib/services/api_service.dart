import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';

class ApiService {
  static String get baseUrl {
    const url = String.fromEnvironment('API_BASE_URL', defaultValue: '');
    if (url.isEmpty) {
      throw Exception("API_BASE_URL is not set. Use --dart-define when running.");
    }
    return url;
  }

  static Future<void> addMeal(String imageData, String aiResponse) async {
    if (baseUrl.isEmpty) {
      throw Exception("API_BASE_URL is not set. Use --dart-define when running.");
    }

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'imageData': imageData,
        'aiResponse': aiResponse,
      }),
    );

    log("Response: ${response.statusCode} ${response.body}");

    if (response.statusCode == 201) {
      log("Meal added successfully!");
    } else {
      log("Failed to add meal: ${response.body}");
    }
  }

  static Future<List<dynamic>> getMeals() async {
    if (baseUrl.isEmpty) {
      throw Exception("API_BASE_URL is not set. Use --dart-define when running.");
    }

    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load meals");
    }
  }
}
