import 'package:flutter/material.dart';

// get current month
int getMonth() {
  DateTime today = DateTime.now();
  int month = today.month;
  return month;
}

final List<String> monthList = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];
final List<DropdownMenuItem<String>> dropDownMonths = monthList
    .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
    .toList();

// getting a list of numbers 1-31
List<int> _getDates() {
  List<int> dates = [];
  for (int i = 1; i <= 31; i++) {
    dates.add(i);
  }
  return dates;
}

final List<int> dates = _getDates();
final List<DropdownMenuItem<int>> dropDownDates = dates
    .map((e) => DropdownMenuItem<int>(value: e, child: Text("$e")))
    .toList();
