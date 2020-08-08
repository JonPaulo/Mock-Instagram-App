// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility that Flutter provides. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:wasteagram/models/food_waste_post.dart';

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
}
