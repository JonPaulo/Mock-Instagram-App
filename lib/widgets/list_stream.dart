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
          return _listOfEntries(snapshot, _goToPost);
        } else {
          return const LoadingCircle();
        }
      },
    );
  }

  void _goToPost(DocumentSnapshot post) {
    Navigator.pushNamed(context, DetailScreen.routeName, arguments: post);
  }

  Widget _listOfEntries(AsyncSnapshot snapshot, Function post) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (content, index) {
              var post = snapshot.data.documents[index];
              return Column(
                children: <Widget>[
                  Semantics(
                    label:
                        'Click to view a post',
                    child: ListTile(
                      key: ValueKey('post-$index'),
                      title: ReadableDate(date: post['date']),
                      trailing: Semantics(
                        label: 'The wasted food count for this post',
                        child: Text(
                          post['quantity'].toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      onTap: () => _goToPost(post),
                    ),
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
  }
}
