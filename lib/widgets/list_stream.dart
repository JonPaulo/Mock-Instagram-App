import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/widgets/readable_date.dart';

import 'loading_circle.dart';

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
                          title: ReadableDate(date: post['date']),
                          trailing: Text(post['quantity'].toString()),
                          onTap: () => goToPost(post),
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
          return const LoadingCircle();
        }
      },
    );
  }

  void goToPost(DocumentSnapshot post) {
    Navigator.pushNamed(context, DetailScreen.routeName, arguments: post);
  }
}
