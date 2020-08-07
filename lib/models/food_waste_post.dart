class FoodWastePost {
  String photoURL;
  int quantity;
  double latitude;
  double longitude;

  // FoodWastePost({this.photoURL, this.quantity, this.latitude, this.longitude});

  Map<String, dynamic> fromMap() {
    return {
      'date': DateTime.now(),
      'photoURL': this.photoURL,
      'quantity': this.quantity,
      'latitude': this.latitude,
      'longitude': this.longitude
    };
  }
}
