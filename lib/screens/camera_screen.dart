import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:plate_calculator/services/api_service.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image; // the image can be null
  String _prediction = '';
  bool _loading = false;

  // Asynchronous function that waits for the user to take their picture from camera
  Future<void> pickCameraImage() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        await sendImageToApi(pickedFile.path);
      }
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Camera permission denied")),
      );
    }
  }

  // Asynchronous function that takes the path to a local image file, sends it via HTTP POST to the Flask server, and waits for the response
  Future<void> sendImageToApi(String imagePath) async {
    setState(() {
      _loading = true;
      _prediction = ''; // clearing the old prediction
    });

    // creating a POST request
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://10.0.2.2:5000/analyze'), // the local host from Android emulator
    );
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));

    // sending the request
    final response = await request.send();

    if (response.statusCode == 200) { // everything went well
      final responseBody = await response.stream.bytesToString(); // convert byte stream to string
      final decoded = json.decode(responseBody); // parse JSON

      setState(() {
        _prediction = decoded['prediction']; // shows the prediction in UI
      });

      // Save meal to Node backend
      final bytes = await File(imagePath).readAsBytes();
      final base64Image = base64Encode(bytes);
      await ApiService.addMeal("data:image/jpeg;base64,$base64Image", decoded['prediction']);
    } else { // something went wrong
      setState(() {
        _prediction = 'Error: ${response.statusCode}';
      });
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Take a Picture')
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: _image != null
                    ? Image.file(_image!, height: 200)
                    : const Text('No image captured 📷'),
                ),
            ),
            const SizedBox(height: 20),
            if (!_loading)
              ElevatedButton(
                onPressed: pickCameraImage,
                child: const Text("Open Camera"),
              ),
            if (_loading)
              const CircularProgressIndicator()
            else if (_prediction.isNotEmpty)
              Text('Prediction: $_prediction', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
