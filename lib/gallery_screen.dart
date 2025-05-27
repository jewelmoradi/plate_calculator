import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  File? _image; // the image can be null

  @override
  void initState() {
    super.initState();
    pickGalleryImage();
  }

  // Asynchronous function that waits for the user to select their picture from their device
  Future<void> pickGalleryImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Gallery Image')
      ),
      body: Center(
        child: _image != null ? Image.file(_image!) : Text('No image selected'),
      ),
    );
  }
}
