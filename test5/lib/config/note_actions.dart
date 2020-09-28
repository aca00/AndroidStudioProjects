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

  Note(this._title, [this._description, this._date, this._starred]);
  
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    if (id != null) {
      map['_id'] = this._id;
    }
    map['title'] = this._title;
    map['date'] = this._date;
    map['description'] = this._description;
    map['starred'] = this._starred;
    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    this._id = map['_id'];
    this._title = map['title'];
    this._description = map['description'];
    this._date = map['date'];
    this._starred = map['starred'];
  }

  set title(String title) {
    this._title = title;
  }

  set description(String des) {
    this._description = des;
  }

  set starred(int star) {
    this._starred = star;
  }

  set date(String date) {
    this._date = date;
  }
}

saveNote(Note note) async {
  if (note.id != null) {
    await DatabaseHelper.instance.update(note.toMap());
  } else {
    await DatabaseHelper.instance.insert(note.toMap());
  }
}

deletNote({int id}) async {
  await DatabaseHelper.instance.delete(id);
}

updateNote({Map<String, dynamic> note}) async {
  await DatabaseHelper.instance.update(note);
}

Future<List<Note>> getNoteList() async {
  var result = await DatabaseHelper.instance.queryAll();
  List<Note> noteList = List<Note>();
  int count = result.length;
  for (int i = 0; i < count; i++) {
    noteList.add(Note.fromMap(result[i]));
  }

  return noteList;
}
