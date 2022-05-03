import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class uploadImage extends StatefulWidget {
  const uploadImage({Key? key}) : super(key: key);

  @override
  State<uploadImage> createState() => _uploadImageState();
}

class _uploadImageState extends State<uploadImage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Upload Image'),
      content: Column(children: <Widget>[
        const IconButton(icon: Icon(Icons.camera), onPressed: null)
      ]),
    );
  }
}
