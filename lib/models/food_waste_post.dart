class FoodWastePost {
  DateTime date;
  String imageURL;
  int quantity;
  double latitude;
  double longitude;

  FoodWastePost({this.date, this.imageURL, this.quantity, this.latitude, this.longitude});

  Map<String, dynamic> submitData() {
    this.date = this.date ?? DateTime.now();
    return {
      'date': this.date,
      'imageURL': this.imageURL,
      'quantity': this.quantity,
      'latitude': this.latitude,
      'longitude': this.longitude
    };
  }
}
