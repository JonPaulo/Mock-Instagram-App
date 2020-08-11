import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

import '../widgets/list_stream.dart';
import '../widgets/add_new_post.dart';

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
      bottomNavigationBar: AddNewPostButton(analytics, getWasteCount),
    );
  }

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
}
