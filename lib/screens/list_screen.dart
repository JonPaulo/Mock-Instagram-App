import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'detail_screen.dart';

import 'package:intl/intl.dart';

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
                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(DateFormat('MMMM dd, yyyy')
                              .format((post['date'].toDate()))),
                          onTap: () => Navigator.pushNamed(
                              context, DetailScreen.routeName,
                              arguments: snapshot.data.documents[index]),
                        ),
                        Divider(height: 1),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: RaisedButton(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Icon(Icons.camera_alt, color: Colors.white),
                      shape: CircleBorder(
                          side: BorderSide(style: BorderStyle.none)),
                      padding: EdgeInsets.all(15),
                      onPressed: () {
                        Navigator.of(context).pushNamed(DetailScreen.routeName);
                      },
                    ),
                  ),
                  RaisedButton(
                      child: Text("Add New Post"),
                      onPressed: () {
                        Firestore.instance.collection('posts').add(
                          {
                            'title': 'Example Title',
                            'date': DateTime.now(),
                          },
                        );
                      })
                ],
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
