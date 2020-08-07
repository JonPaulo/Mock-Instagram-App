import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
      appBar: AppBar(title: Text("Wasteagram")),
      body: Column(
        children: <Widget>[
          Text(
            DateFormat('MMMM dd, yyyy').format((data['date'].toDate())),
            style: Theme.of(context).textTheme.headline5,
          ),
          Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Image.network(data['photoURL'])),
          Text(
            "Wasted Food: ${data['quantity']}",
            style: Theme.of(context).textTheme.headline5,
          ),
          Padding(
            padding: EdgeInsets.all(30),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(data['latitude'].toString()),
              Text(data['longitude'].toString()),
            ],
          ),
        ],
      ),
    );
  }
}
