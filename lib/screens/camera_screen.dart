import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image; // the image can be null

  // Asynchronous function that waits for the user to take their picture from camera
  Future<void> pickCameraImage() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } else {
      // Show a message: Permission denied
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
        onPressed: pickCameraImage,
        child: Text('Open camera'),
      ),
    );
  }
}
