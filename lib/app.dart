import 'package:flutter/material.dart';
import 'package:wasteagram/screens/detail_screen.dart';

import 'screens/list_screen.dart';
import 'screens/new_post.dart';

class App extends StatelessWidget {
  static final routes = {
    ListScreen.routeName: (context) => ListScreen(),
    DetailScreen.routeName: (context) => DetailScreen(),
    NewPost.routeName: (context) => NewPost(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
    );
  }
}
