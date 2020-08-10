// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility that Flutter provides. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:wasteagram/models/food_waste_post.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/screens/new_post.dart';

void main() {
  test(
    'Post created from Map should have appropriate property values',
    () {
      print("Testing...");
      final date = DateTime.parse('2020-01-01');
      const url = 'FAKE';
      const quantity = 1;
      const latitude = 1.0;
      const longitude = 2.0;

      final foodWastePost = FoodWastePost(
        date: date,
        photoURL: url,
        quantity: quantity,
        latitude: latitude,
        longitude: longitude,
      );

      expect(foodWastePost.date, date);
      expect(foodWastePost.photoURL, url);
      expect(foodWastePost.quantity, quantity);
      expect(foodWastePost.latitude, latitude);
      expect(foodWastePost.longitude, longitude);
    },
  );

  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows building and interacting
  // with widgets in the test environment.
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(MyWidget(title: 'T', message: 'M'));

    // Create the Finders.
    final titleFinder = find.byType(Scaffold);
    final messageFinder = find.text('M');

    // Use the `findsOneWidget` matcher provided by flutter_test to
    // verify that the Text widgets appear exactly once in the widget tree.
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}

class MyWidget extends StatelessWidget {
  final String title;
  final String message;

  const MyWidget({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(child: Text(message)),
      ),
    );
  }

}
