import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'detail_screen.dart';

class ListScreen extends StatelessWidget {
  static final routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Wasteagram")),
      body: Container(child: ListStream()),
    );
  }
}

class ListStream extends StatefulWidget {
  @override
  _ListStreamState createState() => _ListStreamState();
}

class _ListStreamState extends State<ListStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('posts').snapshots(),
      builder: (content, snapshot) {
        if (snapshot.hasData && snapshot.data.documents.length > 0) {
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (content, index) {
                    var post = snapshot.data.documents[index];
                    return ListTile(title: Text(post['title']));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RaisedButton(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Icon(Icons.camera_alt, color: Colors.white),
                  shape:
                      CircleBorder(side: BorderSide(style: BorderStyle.none)),
                  padding: EdgeInsets.all(15),
                  onPressed: () {
                    Navigator.of(context).pushNamed(DetailScreen.routeName);
                  },
                ),
              )
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
