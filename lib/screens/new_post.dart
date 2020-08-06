import 'package:flutter/material.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';

class NewPost extends StatefulWidget {
  static final routeName = 'newPost';
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
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
    return Scaffold(
      appBar: AppBar(title: Text("Add New Post")),
      body: selectImage(),
    );
  }

  Widget selectImage() {
    if (_image == null) {
      return Center(
        child: RaisedButton(
            child: Text("Select Photo"),
            onPressed: () {
              getImage();
            }),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(height: 400, child: Image.file(_image)),
            WasteEntry(),
            RaisedButton(
                color: Colors.blue,
                child: Icon(Icons.cloud_upload, color: Colors.white),
                shape: CircleBorder(side: BorderSide(style: BorderStyle.none)),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                onPressed: () {})
          ],
        ),
      );
    }
  }
}

class WasteEntry extends StatefulWidget {
  @override
  _WasteEntryState createState() => _WasteEntryState();
}

class _WasteEntryState extends State<WasteEntry> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(),
      decoration: InputDecoration(labelText: "Number of Wasted Items"),
    );
  }
}
