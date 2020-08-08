import 'package:flutter/material.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:wasteagram/models/food_waste_post.dart';

import 'package:location/location.dart';

class NewPost extends StatefulWidget {
  static final routeName = 'newPost';
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  File _image;

  final formKey = GlobalKey<FormState>();
  final _foodWastePost = FoodWastePost();

  Location location = Location();
  LocationData _locationData;

  bool _serviceEnabled;

  PermissionStatus _permissionGranted;

  @override
  initState() {
    super.initState();
    askForApproval();
    getImage();
  }

  Future getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    try {
      _image = File(pickedFile.path);
      setState(() {});
    } catch (e) {
      print("Error: $e");
      Navigator.of(context).pop();
    }
  }

  Future uploadPhoto() async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(Path.basename(_image.path));
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    _foodWastePost.photoURL = await storageReference.getDownloadURL();
    _locationData = await location.getLocation();
    _foodWastePost.longitude = _locationData.longitude;
    _foodWastePost.latitude = _locationData.latitude;
    print('Photo uploaded. ${_foodWastePost.photoURL}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Post"),
        backgroundColor: Color(0xFF225374),
      ),
      body: selectImage(),
    );
  }

  Widget selectImage() {
    if (_image == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(top: 20),
                  height: 400,
                  child: Image.file(_image)),
              wasteEntry(),
              RaisedButton(
                color: Color(0xFF225374),
                child: Icon(Icons.cloud_upload, color: Colors.white),
                shape: CircleBorder(side: BorderSide(style: BorderStyle.none)),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                onPressed: () {
                  addPost();
                },
              )
            ],
          ),
        ),
      );
    }
  }

  void addPost() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      await uploadPhoto();
      await submitWastePost(_foodWastePost);
      Navigator.pop(context);
    }
  }

  Future submitWastePost(FoodWastePost post) async {
    Firestore.instance.collection('posts').add(_foodWastePost.fromMap());
  }

  Widget wasteEntry() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        keyboardType: TextInputType.numberWithOptions(),
        decoration: InputDecoration(labelText: "Number of Wasted Items"),
        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
        onSaved: (choice) {
          _foodWastePost.quantity = int.parse(choice);
        },
        validator: (value) {
          return value.isEmpty ? 'Wasted item count must not be empty' : null;
        },
      ),
    );
  }

  void askForApproval() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {});
  }

  void retrieveLocation() async {
    _locationData = await location.getLocation();
    print("location data: $_locationData");
    setState(() {});
  }
}
