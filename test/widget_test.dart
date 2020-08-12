// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility that Flutter provides. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import '../lib/models/food_waste_post.dart';

void main() {
  var foodWastePost;

  test(
    'Post has appropriate property values and returns Map data',
    () {
      final date = DateTime.parse('2020-01-01');
      const url = 'google.com';
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

      var firebaseMappedData = <String, dynamic>{
        'date': DateTime.parse('2020-01-01'),
        'imageURL': 'google.com',
        'latitude': 1.0,
        'longitude': 2.0,
        'quantity': 1,
      };

      expect(foodWastePost.submitData(), isMap);
      expect(foodWastePost.submitData(), firebaseMappedData);
    },
  );

  test(
    'Date, quantity, latitude, & longitude are auto-filled if arguments are empty',
    () {
      const url = 'google.com';

      var newPost = FoodWastePost(
        imageURL: url,
      );

      expect(newPost.date, isNull);
      newPost.submitData();
      expect(newPost.date, isNotNull);
      expect(newPost.date, isInstanceOf<DateTime>());

      expect(newPost.imageURL, url);
      expect(newPost.quantity, 0);
      expect(newPost.latitude, 0);
      expect(newPost.longitude, 0);
    },
  );

  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows building and interacting
  // with widgets in the test environment.

//   testWidgets('My Widget can upload', (WidgetTester tester) async {
//     // Create the widget by telling the tester to build it.
//     // await tester.pumpWidget(App());

//     // final fdsa = ListScreen();

//     await tester.runAsync(() async {
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             appBar: AppBar(),
//             body: ListScreen(),
//           ),
//         ),
//       );
//       await tester.idle();
//       await tester.pump(Duration.zero);

//     });

//     // Create the Finders.
//     final test = find.byKey(Key('streamBuilder'));
//     expect(test, findsOneWidget);
//     await tester.pump(Duration(seconds: 5));

//     await tester.pump(Duration.zero);

//     final test2 = find.byKey(Key('addPostButton'));
//     expect(test2, findsOneWidget);

//     await tester.pump(Duration(seconds: 10));
//     await tester.pump(Duration.zero);


//     await tester.pump(Duration(seconds: 3));
//     await tester.tap(find.byTooltip('shutter'));

//     await tester.pump(Duration(seconds: 3));
//     await tester.any(finder)
//     await tester.sendKeyEvent(LogicalKeyboardKey(keyId)'return');
//     await tester.tap(find.byTooltip('done'));

//     final test3 = find.byKey(Key('newPost'));
//     expect(test3, findsWidgets);

//     await tester.pump();
//     // final shutter = find.bySemanticsLabel('shutter');
//     // final shutter = find.text('shutter');
//     // final shutter = find.widgetWithIcon(Icon, Icons.camera_alt);

//     // Use the `findsOneWidget` matcher provided by flutter_test to
//     // verify that the Text widgets appear exactly once in the widget tree.
//     // expect(shutter, findsOneWidget);
//   });
// }

// class MyWidget extends StatelessWidget {
//   final String title;
//   final String message;

//   const MyWidget({
//     Key key,
//     @required this.title,
//     @required this.message,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       home: Scaffold(
//         appBar: AppBar(title: Text(title)),
//         body: Center(child: Text(message)),
//       ),
//     );
//   }
}
