import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../screens/detail_screen.dart';

class ListStream extends StatefulWidget {
  @override
  _ListStreamState createState() => _ListStreamState();
}

class _ListStreamState extends State<ListStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      key: Key('streamBuilder'),
      stream: Firestore.instance
          .collection('posts')
          .orderBy('date', descending: true)
          .snapshots(),
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
                          key: ValueKey('post-$index'),
                          title: Text(DateFormat('MMMM dd, yyyy')
                              .format((post['date'].toDate()))),
                          trailing: Text(post['quantity'].toString()),
                          onTap: () => Navigator.pushNamed(
                              context, DetailScreen.routeName,
                              arguments: snapshot.data.documents[index]),
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
