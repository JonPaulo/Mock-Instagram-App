import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../helpers/custom_padding.dart';
import '../models/food_waste_post.dart';
import '../services/upload_services.dart';
import '../widgets/loading_circle.dart';

class NewPostScreen extends StatefulWidget {
  static final routeName = 'newPost';
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  _NewPostScreenState createState() =>
      _NewPostScreenState(analytics: analytics, observer: observer);
}

class _NewPostScreenState extends State<NewPostScreen> {
  File _image;

  final formKey = GlobalKey<FormState>();
  final _foodWastePost = FoodWastePost();

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  _NewPostScreenState({this.analytics, this.observer});

  @override
  initState() {
    super.initState();
    _getImage();
  }

  Future _getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    try {
      _image = File(pickedFile.path);
      setState(() {});
    } catch (error, stackTrace) {
      print("Error: $error");
      reportError(error, stackTrace);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: Key('newPost'),
        title: Text("Add New Post"),
        backgroundColor: Color(0xFF225374),
      ),
      body: _entryForm(),
      bottomNavigationBar: submitPostButton(context),
    );
  }

  Widget _entryForm() {
    if (_image == null) {
      return LoadingCircle();
    } else {
      return SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              _imageContainer(_image),
              _wasteEntryForm(),
              throwAnError(),
            ],
          ),
        ),
      );
    }
  }

  Widget _imageContainer(File image) {
    return Container(
      padding:
          EdgeInsets.only(top: customPadding(context, columnSpacing: true)),
      height: customPadding(context, imageHeight: true),
      child: Semantics(
          label: 'This will be the image you use for your post',
          child: Image.file(_image)),
    );
  }

  Widget _wasteEntryForm() {
    return Padding(
      padding: EdgeInsets.all(customPadding(context, columnSpacing: true)),
      child: Semantics(
        label: 'Enter the amount of wasted food items you see',
        excludeSemantics: true,
        child: TextFormField(
          key: Key('enterWasteCount'),
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
      ),
    );
  }

  Widget throwAnError() {
    return RaisedButton(
      child: Text("Throw an Error"),
      onPressed: () {
        try {
          print(int.parse('fdsa'));
        } catch (error, stackTrace) {
          print("Error: $error");
          reportError(error, stackTrace);
        }
      },
    );
  }

  GestureDetector submitPostButton(BuildContext context) {
    return GestureDetector(
      child: Semantics(
        key: Key('submitPost'),
        hint: 'Submit your post online',
        child: Container(
          height: customPadding(context),
          child: BottomAppBar(
            color: Color(0xFF225374),
            child: Icon(
              Icons.cloud_upload,
              color: Colors.white,
              size: customPadding(context),
            ),
          ),
        ),
      ),
      onTap: () {
        _addPost();
      },
    );
  }

  void _addPost() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      await uploadPhoto(_foodWastePost, _image);
      await submitWastePost(_foodWastePost);
      analytics.logEvent(
        name: 'post_uploaded',
        parameters: <String, dynamic>{
          'event': 'The user has uploaded a new post'
        },
      );
      Navigator.pop(context, 'update');
    }
  }
}
