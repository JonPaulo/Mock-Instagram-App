// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility that Flutter provides. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:wasteagram/models/food_waste_post.dart';
import 'package:flutter/material.dart';
// import 'package:wasteagram/screens/new_post.dart';
// import 'package:wasteagram/app.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/screens/list_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';

void main() {
  var foodWastePost;

  test(
    'Post created from Map should have appropriate property values',
    () {
      print("Testing...");
      final date = DateTime.parse('2020-01-01');
      const url = 'FAKE';
      const quantity = 1;
      const latitude = 1.0;
      const longitude = 2.0;

      foodWastePost = FoodWastePost(
        date: date,
        imageURL: url,
        quantity: quantity,
        latitude: latitude,
        longitude: longitude,
      );

      expect(foodWastePost.date, date);
      expect(foodWastePost.imageURL, url);
      expect(foodWastePost.quantity, quantity);
      expect(foodWastePost.latitude, latitude);
      expect(foodWastePost.longitude, longitude);
    },
  );

  test('Post created from Map should have appropriate property values', () {
    print("Map Data");

    expect(foodWastePost.submitData(), isMap);

    print(foodWastePost.submitData());
  });

  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows building and interacting
  // with widgets in the test environment.

  testWidgets('My Widget can upload', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    // await tester.pumpWidget(App());

    // final fdsa = ListScreen();

    await tester.runAsync(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: AppBar(),
            body: ListScreen(),
          ),
        ),
      );
      await tester.idle();
      await tester.pump(Duration.zero);

      // await tester.idle();
    });

    final test = find.byKey(Key('streamBuilder'));
    expect(test, findsOneWidget);
    await tester.pump(Duration(seconds: 5));

    await tester.pump(Duration.zero);

    final test2 = find.byKey(Key('addPostButton'));
    expect(test2, findsOneWidget);

    await tester.pump(Duration(seconds: 10));
    await tester.pump(Duration.zero);
    await tester.pump(Duration.zero);

    final test3 = find.byKey(Key('jkj'));
    expect(test3, findsWidgets);
    // Create the Finders.
    // final addButton = find.byKey(Key('add-button'));

    await tester.runAsync(() async {
      expect(test2, findsOneWidget);
      print("fdsa");
    });

    await tester.pump(Duration(seconds: 3));
    // final firstPost = find.byKey(ValueKey('post-0'));
    // expect(firstPost, findsOneWidget);

    // final firstPost = find.byKey(ValueKey('post-0'));
    // expect(firstPost, findsOneWidget);
    // expect(addButton, findsOneWidget);
    // await tester.tap(firstPost);

    print("dsafdasfasf");

    await tester.pump();
    // final shutter = find.bySemanticsLabel('shutter');
    // final shutter = find.text('shutter');
    // final shutter = find.widgetWithIcon(Icon, Icons.camera_alt);

    // Use the `findsOneWidget` matcher provided by flutter_test to
    // verify that the Text widgets appear exactly once in the widget tree.
    // expect(shutter, findsOneWidget);
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
