import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class DetailScreen extends StatefulWidget {
  static final routeName = 'detailScreen';
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  File _image;

  void getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile == null) {
      } else {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_image == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Post Details")),
        body: Center(
          child: RaisedButton(
            child: Text("Select Photo"),
            onPressed: () {
              getImage();
            },
          ),
        ),
      );
    }
    return Container(
      child: Image.file(_image),
    );
  }
}
