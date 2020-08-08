class FoodWastePost {
  DateTime date;
  String photoURL;
  int quantity;
  double latitude;
  double longitude;

  FoodWastePost({this.date, this.photoURL, this.quantity, this.latitude, this.longitude});

  Map<String, dynamic> submitData() {
    this.date = DateTime.now();
    return {
      'date': this.date,
      'photoURL': this.photoURL,
      'quantity': this.quantity,
      'latitude': this.latitude,
      'longitude': this.longitude
    };
  }
}
