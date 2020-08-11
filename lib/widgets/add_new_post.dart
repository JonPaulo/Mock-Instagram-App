import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../screens/new_post.dart';

class AddNewPostButton extends StatelessWidget {

  final FirebaseAnalytics analytics;
  final Function getWasteCount;

  const AddNewPostButton(this.analytics, this.getWasteCount);

  void makeNewPost(BuildContext context) async {
    analytics.logEvent(
      name: 'new_post',
      parameters: <String, dynamic>{'event': 'The user wanted to add a new post'},
    );
    print("Analytics fired.");
    var result = await Navigator.pushNamed(context, NewPost.routeName);
    if (result.toString() == 'update') {
      getWasteCount();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
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
        onTap: () => makeNewPost(context),
      ),
    );
  }
}
