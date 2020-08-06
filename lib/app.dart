import 'package:flutter/material.dart';

import 'screens/list_screen.dart';

class App extends StatelessWidget {
  static final routes = {
    ListScreen.routeName: (context) => ListScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
    );
  }
}
