import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdatingAppBar extends StatefulWidget with PreferredSizeWidget {
  const UpdatingAppBar({Key key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  _UpdatingAppBarState createState() => _UpdatingAppBarState();
}

class _UpdatingAppBarState extends State<UpdatingAppBar> {
  int quantity = 0;

  void getWasteCount() async {
    QuerySnapshot snapshot =
        await Firestore.instance.collection('posts').getDocuments();
    snapshot.documents.forEach(
      (element) {
        quantity += element.data['quantity'];
      },
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getWasteCount();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Wasteagram: $quantity"),
      backgroundColor: Color(0xFF225374),
    );
  }
}
