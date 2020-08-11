import 'package:flutter/material.dart';
import '../helpers/custom_padding.dart';

class ItemCountText extends StatelessWidget {
  final int quantity;

  ItemCountText(this.quantity);

  String get itemsText {
    return quantity == 1 ? 'item' : 'items';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: customPadding(context, columnSpacing: true)),
      child: Semantics(
        label: 'This post contains a waste count of $quantity $itemsText',
        excludeSemantics: true,
        child: Text(
          "$quantity $itemsText",
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}
