import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/helpers/custom_padding.dart';

import '../widgets/item_count_text.dart';
import '../widgets/readable_date.dart';

class DetailScreen extends StatefulWidget {
  static final routeName = 'detailScreen';

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    DocumentSnapshot data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Wasteagram"),
        backgroundColor: Color(0xFF225374),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            datePosted(data, context),
            imageContainer(context, data),
            ItemCountText(data['quantity']),
            locationText(data, context),
          ],
        ),
      ),
    );
  }

  Padding datePosted(DocumentSnapshot data, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: customPadding(context, columnSpacing: true)),
      child: ReadableDate(
        date: data['date'],
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Container imageContainer(BuildContext context, DocumentSnapshot data) {
    return Container(
      alignment: Alignment.center,
      height: customPadding(context, imageHeight: true),
      child: Semantics(
        label: 'The image for the current post',
        child: Image.network(data['imageURL']),
      ),
    );
  }

  Padding locationText(DocumentSnapshot data, BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: customPadding(context, columnSpacing: true)),
      child: Center(
        child: Semantics(
          label:
              'This post was taken at latitude ${data['latitude'].toString()}, '
              'longitude ${data['longitude'].toString()}',
          excludeSemantics: true,
          child: Text(
            'Location: (${data['latitude'].toString()}, '
            '${data['longitude'].toString()})',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ),
    );
  }
}
