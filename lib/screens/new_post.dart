import 'package:flutter/material.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';

class NewPost extends StatefulWidget {
  static final routeName = 'newPost';
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  File _image;

  String url;

  Future getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    try {
      _image = File(pickedFile.path);
      setState(() {});
    } catch (e) {
      print("Error: $e");
    }
  }

  Future uploadPhoto() async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(Path.basename(_image.path));
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    url = await storageReference.getDownloadURL();
    print('Photo uploaded. $url');
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
              onPressed: () {
                addPost();
                Navigator.pop(context, 'update');
              },
            )
          ],
        ),
      );
    }
  }

  void addPost() async {
    await uploadPhoto();
    Firestore.instance.collection('posts').add(
      {
        'title': 'Example Title',
        'date': DateTime.now(),
        'url': url,
      },
    );
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
