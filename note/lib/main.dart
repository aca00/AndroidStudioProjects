import 'package:note/screens/edit_notes.dart';
import 'package:note/screens/testing.dart';
import 'package:flutter/material.dart';
import 'package:note/screens/settings.dart';
import 'package:note/screens/aboutUs.dart';
import 'package:note/screens/noteitHomePage.dart';
import 'package:note/utils/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
      debugShowCheckedModeBanner: false,
      home: NoteItHomePageScreen(),
    );
  }
}
