import 'package:flutter/material.dart';
import 'dart:io';
import 'package:plate_calculator/services/api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  File? _image; // the image can be null
  String _prediction = '';
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  // Asynchronous function that waits for the user to select their picture from their device
  Future<void> pickGalleryImage() async {
    var status = await Permission.photos.request(); // or Permission.mediaLibrary on some Android
    if (status.isGranted) {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        await sendImageToApi(pickedFile.path);
      }
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gallery permission denied")),
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
          title: Text('Select Image')
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
                    : Text('No image selected 😢'),
              ),
            ),
            const SizedBox(height: 20,),
            if (!_loading)
              ElevatedButton(
                  onPressed: pickGalleryImage,
                  child: Text("Pick From Gallery"),
              ),
            if (_loading)
              CircularProgressIndicator()
            else if (_prediction.isNotEmpty)
              Text('Prediction: $_prediction', style: TextStyle(fontSize: 18),)
          ],
        ),
      ),
    );
  }
}
