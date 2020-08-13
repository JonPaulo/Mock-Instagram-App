// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility that Flutter provides. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import '../lib/models/food_waste_post.dart';

void main() {
  test(
    'Post has appropriate property values and returns Map data',
    () {
      final date = DateTime.parse('2020-01-01');
      const url = 'google.com';
      const quantity = 1;
      const latitude = 1.0;
      const longitude = 2.0;

      final foodWastePost = FoodWastePost(
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

      final newPost = FoodWastePost(
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
}
