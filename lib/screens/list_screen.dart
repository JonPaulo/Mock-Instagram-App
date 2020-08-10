import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

import 'new_post.dart';
import '../widgets/list_stream.dart';

class ListScreen extends StatefulWidget {
  static final routeName = '/';
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  ListScreen({this.analytics, this.observer});

  @override
  ListScreenState createState() =>
      ListScreenState(analytics: analytics, observer: observer);
}

class ListScreenState extends State<ListScreen> {
  final analytics;
  final observer;
  ListScreenState({this.analytics, this.observer});

  int quantity = 0;

  void getWasteCount() async {
    quantity = 0;
    QuerySnapshot snapshot =
        await Firestore.instance.collection('posts').getDocuments();
    snapshot.documents.forEach(
      (element) {
        quantity += element.data['quantity'];
      },
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getWasteCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wasteagram - $quantity"),
        backgroundColor: Color(0xFF225374),
      ),
      body: ListStream(),
      bottomNavigationBar: Semantics(
        key: Key('addPostButton'),
        hint: 'Add a new post',
        child: GestureDetector(
          key: Key('add-button'),
          child: Container(
            height: 50,
            child: BottomAppBar(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              color: Color(0xFF225374),
            ),
          ),
          onTap: () => makeNewPost(),
        ),
      ),
    );
  }

  void makeNewPost() async {
    analytics.logEvent(
      name: 'test_event',
      parameters: <String, dynamic>{'event': 'Upload a new post was pressed'},
    );
    print("Analytics fired.");
    var result = await Navigator.pushNamed(context, NewPost.routeName);
    if (result.toString() == 'update') {
      getWasteCount();
    }
  }
}
