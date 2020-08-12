import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:wasteagram/widgets/readable_date.dart';

import 'loading_circle.dart';

import '../screens/detail_screen.dart';

class ListStream extends StatefulWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  _ListStreamState createState() =>
      _ListStreamState(analytics: analytics, observer: observer);
}

class _ListStreamState extends State<ListStream> {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  _ListStreamState({this.analytics, this.observer});

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
    analytics.logEvent(
      name: 'user_looked_at_post',
      parameters: <String, dynamic>{
        'event': 'The user viewed a post with ${post['quantity']} wasted items'
      },
    );
    Navigator.pushNamed(context, DetailScreen.routeName, arguments: post);
  }

  Widget _listOfEntries(AsyncSnapshot snapshot, Function post) {
    return Column(
      children: [
        Expanded(
          key: Key("here"),
          child: ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (content, index) {
              var post = snapshot.data.documents[index];
              return Column(
                children: <Widget>[
                  Semantics(
                    label: 'Click to view a post',
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
