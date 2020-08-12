import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/services.dart' show rootBundle;
import 'package:location/location.dart';
import 'package:path/path.dart' as Path;
import 'package:sentry/sentry.dart' as Sentry;

import '../models/food_waste_post.dart';

// Uploads the image to Cloud Storage
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

// Ask for approval to use current location
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

// Submits the model data to Cloud Firestore
Future submitWastePost(FoodWastePost _foodWastePost) async {
  Firestore.instance.collection('posts').add(_foodWastePost.submitData());
}

Future<void> reportError(dynamic error, dynamic stackTrace) async {
  // if (Foundation.kDebugMode) {
  //   print(stackTrace);
  //   return;
  // }
  String dsn = await rootBundle.loadString('assets/sentry_dsn.txt');
  Sentry.SentryClient sentry = Sentry.SentryClient(dsn: dsn);

  final Sentry.SentryResponse response =
      await sentry.captureException(exception: error, stackTrace: stackTrace);
  if (response.isSuccessful) {
    print('NO PHOTO SELECTED. ERROR REPORTED TO SENTRY');
    print('Sentry ID: ${response.eventId}');
  } else {
    print('Failed to report to Sentry: ${response.error}');
  }
}
