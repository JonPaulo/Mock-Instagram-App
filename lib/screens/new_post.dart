import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../models/food_waste_post.dart';
import '../services/upload_services.dart';
import '../widgets/loading_circle.dart';

class NewPost extends StatefulWidget {
  static final routeName = 'newPost';

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  File _image;

  final formKey = GlobalKey<FormState>();
  final _foodWastePost = FoodWastePost();

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
    } catch (error) {
      print("Error: $error");
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
              _submitPost(_addPost),
            ],
          ),
        ),
      );
    }
  }

  Widget _imageContainer(File image) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      height: 400,
      child: Semantics(
        label: 'This will be the image you use for your post',
        child: Image.file(_image)),
    );
  }

  Widget _wasteEntryForm() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
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

  Widget _submitPost(Function addPost) {
    return Semantics(
      key: Key('submitPost'),
      hint: 'Submit your post online',
      child: RaisedButton(
        color: Color(0xFF225374),
        child: Icon(Icons.cloud_upload, color: Colors.white),
        shape: CircleBorder(side: BorderSide(style: BorderStyle.none)),
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        onPressed: () {
          addPost();
        },
      ),
    );
  }

  void _addPost() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      await uploadPhoto(_foodWastePost, _image);
      await submitWastePost(_foodWastePost);
      Navigator.pop(context, 'update');
    }
  }
}
