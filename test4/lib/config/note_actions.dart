import 'database_helper.dart';
import 'package:flutter/material.dart';

final String _empty = '';

class Note {
  String _title;
  String _date;
  String _description;
  int _starred;
  int _id;

  String get title => this._title;
  String get date => this._date;
  String get description => this._description;
  int get id => this._id;
  int get starred => this._starred;

  Note(this._title, this._description, this._date, this._starred);
  Map<String, dynamic> toMap() {
    Map map = Map();
    map['title'] = this._title;
    map['date'] = this._date;
    map['description'] = this._description;
    map['starred'] = this._starred;
  }

  
}

saveNote({String title, String des, int star, String date}) async {
  if (title != _empty && des != _empty) {
    debugPrint('  No note added');
    await DatabaseHelper.instance.insert({
      DatabaseHelper.title: title,
      DatabaseHelper.description: des,
      DatabaseHelper.starred: star ?? 0,
    });
  } else if (title == _empty && des != _empty) {
    await DatabaseHelper.instance.insert({
      DatabaseHelper.title: 'Untitled',
      DatabaseHelper.description: des,
      DatabaseHelper.starred: star ?? 0,
    });
  } else if (title == _empty && des == _empty) {
    debugPrint('  No note added');
  } else {
    await DatabaseHelper.instance.insert({
      DatabaseHelper.title: title,
      DatabaseHelper.description: des,
      DatabaseHelper.starred: star ?? 0,
    });
  }
}

deletNote({int id}) async {
  await DatabaseHelper.instance.delete(id);
}

updateNote({Map<String, dynamic> note}) async {
  await DatabaseHelper.instance.update(note);
}
