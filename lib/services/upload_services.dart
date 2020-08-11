import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';
import 'package:path/path.dart' as Path;

import '../models/food_waste_post.dart';

Future uploadPhoto(FoodWastePost _foodWastePost, File _image) async {
  Location location = Location();
  LocationData _locationData;

  _askForApproval(location, _locationData);

  StorageReference storageReference =
      FirebaseStorage.instance.ref().child(Path.basename(_image.path));
  StorageUploadTask uploadTask = storageReference.putFile(_image);
  await uploadTask.onComplete;
  _foodWastePost.imageURL = await storageReference.getDownloadURL();
  _locationData = await location.getLocation();
  _foodWastePost.longitude = _locationData.longitude;
  _foodWastePost.latitude = _locationData.latitude;
  print('Photo uploaded. ${_foodWastePost.imageURL}');
}

void _askForApproval(Location location, LocationData _locationData) async {
  bool _serviceEnabled;

  PermissionStatus _permissionGranted;
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
}

Future submitWastePost(FoodWastePost _foodWastePost) async {
  Firestore.instance.collection('posts').add(_foodWastePost.submitData());
}
