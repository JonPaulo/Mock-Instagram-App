import 'package:flutter/material.dart';

double customPadding(BuildContext context,
    {bool columnSpacing, bool imageHeight}) {
  if (columnSpacing == true) {
    return MediaQuery.of(context).size.height * 0.03;
  } else if (imageHeight == true) {
    return MediaQuery.of(context).size.height * 0.5;
  } else {
    return MediaQuery.of(context).size.height * 0.1;
  }
}
