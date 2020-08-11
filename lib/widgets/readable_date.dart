import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReadableDate extends StatelessWidget {
  final Timestamp date;
  final TextStyle style;
  ReadableDate({this.date, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(DateFormat('MMMM dd, yyyy').format(date.toDate()), style: style,);
  }
}
