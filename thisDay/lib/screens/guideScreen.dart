import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

// const String _data = '''
// asdfadsfadfadsfafasdfadfafasdf
// ''';

class GuideScreen extends StatelessWidget {
  final _appBarTitle;
  final _selectGuide;
  GuideScreen(this._appBarTitle, this._selectGuide);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this._appBarTitle),
      ),
      body: _getGuide(this._selectGuide),
    );
  }
}

Markdown _getGuide(String guide) {
  if (guide == 'howToSearch') {
    return Markdown(
      data: _howToSearchGuide,
    );
  }
  return null;
}

const String _myEmailId = 'example@gmail.com';

const String _howToSearchGuide = '''
This app uses `SQLite` to manage the database. So searches are `SQLite` queries.

- All fields are case insensitive. That means 'September', 'sEptemBer', 'SEPTEMBER'... all same.
- You can pass `null` as a valid parameter.
- You can't pass the month number (For example 1 for January) in the month field. You have to type the month name or give a regex expression. 
- Within a field, you can define constraints using `AND/OR` logic. For example, if you want to fetch events that happened in the years 1920 and 1922, pass `1920 'OR' 1922` in the year field. (_Note:_ Don't omit  those single quotes!)
- To get all events you created, leave all fields empty and hit the 'Go' button.
## Regex
You can use `regex` expressions for advanced queries. Some examples are given below; 
### Using % symbol
- The `s%` pattern matches any string that starts with letter 's' like `star`, `september`, `son`... 
- The `%ly` pattern matches any string that ends with 'ly' like `July`, `Sally`...
- The `%in%` pattern matches any string that contains 'in' like `India`, `Kevin`, `Independence`...
### Using _ symbol
- You can use an underscore (`_`) for an unknown letter. For example `s_n` matches `sun`, `son`, `sin`...

All the best!

''';
