import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

import 'screens/detail_screen.dart';
import 'screens/list_screen.dart';
import 'screens/new_post.dart';

class App extends StatelessWidget {
  static final routes = {
    ListScreen.routeName: (context) => ListScreen(analytics: analytics, observer: observer),
    DetailScreen.routeName: (context) => DetailScreen(),
    NewPost.routeName: (context) => NewPost(),
  };

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      navigatorObservers: [observer],
    );
  }
}
