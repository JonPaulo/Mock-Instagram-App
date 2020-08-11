import 'package:flutter/material.dart';

class ItemCountText extends StatelessWidget {
  final int quantity;

  ItemCountText(this.quantity);

  String get itemsText {
    return quantity == 1 ? 'item' : 'items';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        "$quantity $itemsText",
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
