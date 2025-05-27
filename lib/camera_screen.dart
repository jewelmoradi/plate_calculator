import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image; // the image can be null

  // Asynchronous function that waits for the user to take their picture from camera
  Future<void> _takeCameraImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Image'),
      ),
      body: Center(
        child: _image != null ? Image.file(_image!) : Text('No image selected'),
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: _takeCameraImage,
        child: Text('Open camera'),
      ),
    );
  }
}
