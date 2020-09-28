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
This app uses `SQLite` to manage the database. So searches are `SQLite` queries. It is recommended to have some basic knowledge of `SQLite` if you want to manage your database with another program.

- All fields are case insensitive. That means 'September', 'sEptemBer', 'SEPTEMBER'... all are the same
- You can pass `null` as a valid query for all the fields. This may be helpful in certain cases. As an example suppose you want to see all events for which month is not mentioned explicitly but want to mention now, you can pass `null` in the month field. It will bring you all events where the month is `null`.
- You can't pass the month number (For example 1 for January) in the month field. You have to type month name. You can use regex expression to reduce typing job.
- Within a field you can have multiple constraints connected with `AND/OR` logic. For example, if you need all events that happened in the year 1920 and 1922, just pass `1920 'OR' 1922` in the year field. (_Note:_ Don't omit  those single quotes!)
- To get all events you created, just leave all fields empty and hit 'Go' button.
## Regex
As I already mentioned, you can use `regex` expressions for advanced queries. You can find all of them on the web. For now, I wish to point out two of them that I personally felt helpful.
### Using % symbol
- The `s%` pattern matches any string that starts with letter 's' like `star`, `september`, `son`... 
- The `%ly` pattern matches any string that ends with 'ly' like `July`, `Sally`...
- The `%in%` pattern matches any string that contains 'in' like `India`, `Kevin`, `Independence`...
### Using _ symbol
- You can use underscore (`_`) to replace a letter. For example `s_n` matches `sun`, `son`, `sin`...

All the best !

Can you write a better article? Send your article (in English) at $_myEmailId . Don't forget to mention your name. I will put your article and your name here in the very next update😊

''';
