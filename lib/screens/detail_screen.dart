import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/widgets.dart';

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
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              DateFormat('MMMM dd, yyyy').format((data['date'].toDate())),
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.network(data['photoURL']),
          ),
          ItemCountText(data['quantity']),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Center(
            child: Text(
                'Location: (${data['latitude'].toString()}, ${data['longitude'].toString()})'),
          ),
        ],
      ),
    );
  }
}
