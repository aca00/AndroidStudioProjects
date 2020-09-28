import 'package:thisDay/config/theme_data.dart';
import 'databaseHelper.dart';
import 'package:flutter/material.dart';

class Entry {
  String _title;
  int _year;
  int _month;
  int _day;
  int _parentId;
  String _description;
  int _priority;
  int _id;
  String _monthName;

  String get monthName => this._monthName;
  int get id => this._id;
  int get year => this._year;
  int get month => this._month;
  int get day => this._day;
  String get title => this._title;
  String get description => this._description;
  int get priority => this._priority;
  int get parentId => this._parentId;

  Entry([
    this._priority,
    this._parentId,
    this._title,
    this._year,
    this._month,
    this._day,
    this._description,
  ]);

  Map<String, dynamic> eventToMap() {
    Map<String, dynamic> map = Map();
    if (id != null) {
      map['_id'] = this._id;
    }
    map['year'] = this._year;
    map['month'] = this._month;
    map['day'] = this._day;
    map['title'] = this._title;
    map['description'] = this._description;
    map['priority'] = this._priority;
    map['topic_id'] = this._parentId;
    return map;
  }

  Entry.fromMapToEvent(Map<String, dynamic> map) {
    this._id = map['_id'];
    this._year = map['year'];
    this._month = map['month'];
    this._day = map['day'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._parentId = map['topic_id'];
    this._monthName = map['monthName'];
  }

  Map<String, dynamic> storyToMap() {
    Map<String, dynamic> map = Map();
    if (id != null) {
      map['_id'] = this._id;
    }
    map['title'] = this._title;
    map['description'] = this._description;
    map['topic_id'] = this._parentId;
    return map;
  }

  Entry.fromMapToStory(Map<String, dynamic> map) {
    this._id = map['_id'];
    this._title = map['title'];
    this._description = map['description'];
    this._parentId = map['topic_id'];
  }

  set year(int year) {
    this._year = year;
  }

  set month(int month) {
    if (month >= 1 && month <= 12) {
      this._month = month;
    }
  }

  set day(int day) {
    this._day = day;
  }

  set title(String title) {
    this._title = title;
  }

  set description(String des) {
    this._description = des;
  }

  set priority(int priority) {
    this._priority = priority;
  }

  set parentId(int parentId) {
    this._parentId = parentId;
  }
}

//  save/update event
Future saveEvent(Entry entry) async {
  if (entry.id != null) {
    debugPrint('event id is not null');
    await DatabaseHelper.instance.updateEvent(entry.eventToMap());
  } else {
    debugPrint('event id is null');
    await DatabaseHelper.instance.insertEvent(entry.eventToMap());
  }
}

// deleting all events inside the story
deleteEventsOfStory({int storyId}) async {
  await DatabaseHelper.instance.deleteEventsOfStory(storyId);
}

// delete story from story table
deleteStory({int id}) async {
  await DatabaseHelper.instance.deleteStory(id);
}

// delete event from maintable
deleteEvent({int id}) async {
  await DatabaseHelper.instance.deleteEvent(id);
}

// update changes made on event
updateEvent({Map<String, dynamic> event}) async {
  await DatabaseHelper.instance.updateEvent(event);
}

// get list of all events. Not yet used
Future<List<Entry>> getEventList() async {
  var result = await DatabaseHelper.instance.queryForAllEvents();
  List<Entry> eventList = List<Entry>();
  int count = result.length;
  for (int i = 0; i < count; i++) {
    eventList.add(Entry.fromMapToEvent(result[i]));
  }

  return eventList;
}

// get list of years of story.
Future<List> getYearsOfStory({int storyId, bool changeDetector}) async {
  final result =
      await DatabaseHelper.instance.queryForYearsOfStory(storyId: storyId);
  List<dynamic> yearsList = List<dynamic>();
  int count = result.length;
  for (int i = 0; i < count; i++) {
    yearsList.add(result[i]['year']);
  }
  return yearsList;
}

/// This function takes month number as input and returns list of dates of that
/// month where some event is created. This takes a string value because null is
/// also a valid entry. Instead of string this can be dynamic/int also.

Future<List> getDatesOfMonthList(
    {String mnth, bool checkForStateChange}) async {
  final result = await DatabaseHelper.instance.queryForDatesOfMonth(mnth: mnth);

  List<dynamic> datesList = List<dynamic>();
  int count = result.length;
  for (int i = 0; i < count; i++) {
    datesList.add(result[i]['day']);
  }

  return datesList;
}

Future<List<Entry>> getStoryList({bool checkForStateChange}) async {
  var result = await DatabaseHelper.instance.queryForAllStories();
  int count = result.length;
  List<Entry> listOfStories = List();
  for (int i = 0; i < count; i++) {
    listOfStories.add(Entry.fromMapToStory(result[i]));
  }
  return listOfStories;
}

Future saveStory(Entry entry) async {
  if (entry.id != null) {
    debugPrint('story id is not null');
    await DatabaseHelper.instance.updateStory(entry.storyToMap());
  } else {
    debugPrint('story id is null');
    await DatabaseHelper.instance.insertStory(entry.storyToMap());
  }
}

Future<List<TextSpan>> listOfEventsAtYear(
  BuildContext context,
  dynamic year,
  dynamic storyId,
) async {
  final result = await DatabaseHelper.instance
      .queryForEventsOfTheYearForStory(yr: year, storyId: storyId);
  List<TextSpan> textSpans = [];
  int count = result.length;
  for (int i = 0; i < count; i++) {
    TextStyle getStylings(int i) {
      if (i == 0) {
        return DefaultTextStyle.of(context).style;
      } else {
        return TextStyle(color: getPriorityColor(i));
      }
    }

    final String _mnthName = result[i]['monthName'] ?? '- - - - - - -';

    final String string =
        "- ${_mnthName.substring(0, 3)} ${result[i]['day'] ?? ' '}: ${result[i]['title']}\n";
    textSpans
        .add(TextSpan(text: string, style: getStylings(result[i]['priority'])));
  }

  return textSpans;
}

Future<List<Entry>> getListOfUniversalQuery(
    {dynamic day,
    dynamic monthNumber,
    dynamic year,
    bool changeCheck,
    dynamic storyId,
    dynamic queryCode,
    dynamic universalQuery}) async {
  List<Entry> lst = [];
  if (queryCode == 1) {
    // year screen
    final result = await DatabaseHelper.instance
        .queryForEventsOfTheYearForStory(storyId: storyId, yr: year);

    int count = result.length;

    for (int i = 0; i < count; i++) {
      lst.add(Entry.fromMapToEvent(result[i]));
    }
  } else if (queryCode == 2) {
    // monthscreen
    final result = await DatabaseHelper.instance
        .queryForEventsAtDay(mnth: monthNumber, dy: day);
    debugPrint('  result : ${result}');
    int count = result.length;

    for (int i = 0; i < count; i++) {
      lst.add(Entry.fromMapToEvent(result[i]));
    }
  } else if (queryCode == 3) {
    // goToScreen
    debugPrint(' universal query');
    final result =
        await DatabaseHelper.instance.universalQuery(query: universalQuery);
    debugPrint(' result  : ${result}');
    int count = result.length;
    for (int i = 0; i < count; i++) {
      lst.add(Entry.fromMapToEvent(result[i]));
    }
  } else if (queryCode == 4) {
    final result = await DatabaseHelper.instance.queryForDrafts();
    debugPrint(' result  : ${result}');
    int count = result.length;
    for (int i = 0; i < count; i++) {
      lst.add(Entry.fromMapToEvent(result[i]));
    }
  }

  return lst;
}

Future<List<Entry>> getListOfEventsAtDayToEdit(
    {dynamic day,
    dynamic monthNum,
    bool changeCheck,
    dynamic storyId,
    dynamic year,
    dynamic yearEdit}) async {
  List<Entry> lst = [];
  if (yearEdit != null) {
    final result = await DatabaseHelper.instance
        .queryForEventsOfTheYearForStory(storyId: storyId, yr: year);

    int count = result.length;

    for (int i = 0; i < count; i++) {
      lst.add(Entry.fromMapToEvent(result[i]));
    }
  } else if (yearEdit == null) {
    final result = await DatabaseHelper.instance
        .queryForEventsAtDay(mnth: monthNum, dy: day);

    int count = result.length;

    for (int i = 0; i < count; i++) {
      lst.add(Entry.fromMapToEvent(result[i]));
    }
  }
  return lst;
}

Future<List<TextSpan>> listOfEventsAtDay(
  BuildContext context, {
  dynamic day,
  dynamic monthNum,
}) async {
  final result = await DatabaseHelper.instance
      .queryForEventsAtDay(mnth: monthNum, dy: day);
  List<TextSpan> textSpans = [];
  int count = result.length;
  for (int i = 0; i < count; i++) {
    TextStyle getStylings(int i) {
      if (i == 0) {
        return DefaultTextStyle.of(context).style;
      } else {
        return TextStyle(color: getPriorityColor(i));
      }
    }

    final String string =
        "- ${result[i]['year'] ?? '- - - - '}: ${result[i]['title']}\n";
    textSpans
        .add(TextSpan(text: string, style: getStylings(result[i]['priority'])));
  }

  return textSpans;
}
