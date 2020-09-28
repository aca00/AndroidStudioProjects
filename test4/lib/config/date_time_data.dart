import 'package:flutter/material.dart';

Text getDate() {
  DateTime today = DateTime.now();
  String month = months[today.month - 1];
  String day = days[today.weekday - 1];
  String date = today.day.toString();
  return Text(
    '$day $month $date',
    style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
  );
}

final List<String> months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Nov',
  'Dec'
];
final List<String> days = [
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
  'Sun',
];
