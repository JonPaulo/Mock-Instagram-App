
import 'dart:io';
import 'package:location/location.dart';
import 'package:image_picker/image_picker.dart';

class CloudServices {
  Location location = Location();
  LocationData _locationData;

  bool _serviceEnabled;

  PermissionStatus _permissionGranted;

  Future getImage(File _image) async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    try {
      _image = File(pickedFile.path);
      // setState(() {});
    } catch (e) {
      print("Error: $e");
    }
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
    // setState(() {});
  }

  void retrieveLocation() async {
    _locationData = await location.getLocation();
    print("location data: $_locationData");
    // setState(() {});
  }

}