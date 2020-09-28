import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:thisDay/config/bloc/change_bloc.dart';
import 'package:thisDay/screens/guideScreen.dart';
import 'package:thisDay/screens/monthScreen.dart';
import 'package:thisDay/screens/universalEditScreen.dart';

class GoToScreen extends StatelessWidget {
  final _titleController = TextEditingController();
  final _yearController = TextEditingController();
  final _monthController = TextEditingController();
  final _dayController = TextEditingController();
  final _desciptionController = TextEditingController();
  final List<String> _sortCategories = ['Title', 'Date'];
  final List<String> _sortOrders = ['Ascending', 'Descending'];

  @override
  Widget build(BuildContext context) {
    final _sortBloc = BlocProvider.of<ChangeBloc>(context);

    Query query = Query();

    return WillPopScope(
      onWillPop: () {
        _backToMonthScreen(context);
        return null;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              _backToMonthScreen(context);
            },
          ),
          title: Text('Go to'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          GuideScreen('How to search?', 'howToSearch'),
                    ));
              },
              icon: Icon(Icons.info_outline),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration.collapsed(hintText: 'Title'),
                onChanged: (value) {
                  query.titleQuery = _titleController.text;
                },
              ),
              SizedBox(height: 50),
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration.collapsed(hintText: 'Year'),
                onChanged: (value) {
                  query.yearQuery = _yearController.text;
                },
              ),
              SizedBox(height: 50),
              TextFormField(
                controller: _monthController,
                decoration: InputDecoration.collapsed(hintText: 'Month'),
                onChanged: (value) {
                  query.monthQuery = _monthController.text;
                },
              ),
              SizedBox(height: 50),
              TextFormField(
                controller: _dayController,
                decoration: InputDecoration.collapsed(hintText: 'Day'),
                onChanged: (value) {
                  query.dayQuery = _dayController.text;
                },
              ),
              SizedBox(height: 50),
              TextFormField(
                controller: _desciptionController,
                decoration: InputDecoration.collapsed(hintText: 'Description'),
                onChanged: (value) {
                  query.descriptionQuery = _desciptionController.text;
                },
              ),
              SizedBox(height: 50),
              Text('Sort by :-', style: TextStyle(fontWeight: FontWeight.bold)),
              BlocBuilder<ChangeBloc, ChangeState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Row(
                        children: [0, 1]
                            .map((index) => Row(
                                  children: [
                                    Radio(
                                        value: index,
                                        groupValue: state.sortCategory,
                                        onChanged: (value) {
                                          query.sortCategory = value;
                                          _sortBloc.add(ChangeEvent(
                                              sortCategory: value,
                                              sortOrder: state.sortOrder));
                                        }),
                                    Text(_sortCategories[index]),
                                  ],
                                ))
                            .toList(),
                      ),
                      Row(
                        children: [0, 1]
                            .map((index) => Row(
                                  children: [
                                    Radio(
                                        value: index,
                                        groupValue: state.sortOrder,
                                        onChanged: (value) {
                                          query.sortOrder = value;
                                          _sortBloc.add(ChangeEvent(
                                              sortCategory: state.sortCategory,
                                              sortOrder: value));
                                        }),
                                    Text(_sortOrders[index]),
                                  ],
                                ))
                            .toList(),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 50),
              RaisedButton(
                child: Text('Go'),
                onPressed: () {
                  String quer = createQuery(query);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UniversalEditScreen(
                            'Results', //title
                            null, // day
                            null, // month
                            null, // year
                            null, // storyId
                            3, // queryCode
                            null, // storyName
                            quer),
                      ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _backToMonthScreen(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MonthScreen(),
        ));
  }
}

class Query {
  String titleQuery;
  String yearQuery;
  String monthQuery;
  String dayQuery;
  String descriptionQuery;
  int sortCategory = 0;
  int sortOrder = 0;
}

String createQuery(Query q) {
  // check whether atleast one field is not empty
  _emptyChecker() {
    bool _chk = true; // initially all fields are empty
    Map _mapOfFilters = {
      'm.title': q.titleQuery,
      'm.day': q.dayQuery,
      'monthName': q.monthQuery,
      'm.year': q.yearQuery,
    };

    List filters = [];

    _mapOfFilters.forEach((key, val) {
      if (val != null) {
        if (val != '') {
          _chk = false; // atleast one of the fields is not empty
          filters.add("$key LIKE '$val'");
        }
      }
    });

    return [_chk, filters];
  }

  bool _isEmpty = _emptyChecker()[0]; // false if there is atleast one query
  List _filters = _emptyChecker()[1]; // list of "where" strings
  print('is empty $_isEmpty');

  String _initialStatements = '''
      SELECT m._id, m.year, m.month, m.day, m.title, m.description, 
      m.priority, m.topic_id, mn._id AS monthNo, mn.title AS monthName
      FROM mainTable m
      LEFT JOIN monthTable mn ON m.month = mn._id  
      ''';

  // get all filter queries. item is list of 'where' queries
  String getWhere(List item) {
    String where = '';
    int count = item.length;
    print(count);
    if (count != 0) {
      // assume there is only one filter
      where = where + 'WHERE ${item[0]}';
    }
    if (count > 1) {
      for (int i = 1; i < count; i++) {
        where = where + ' AND ' + item[i];
      }
    }
    return where;
  }

  String orderBy() {
    String order = '';
    if (q.sortCategory == 0) {
      if (q.sortOrder == 0) {
        order = order + 'ORDER BY m.title';
      } else {
        order = order + 'ORDER BY m.title DESC';
      }
    } else {
      if (q.sortOrder == 0) {
        order = order + 'ORDER BY m.year, m.month, m.day';
      } else {
        order = order + 'ORDER BY m.year DESC, m.month DESC, m.day DESC';
      }
    }
    return order;
  }

  print(' sort cat  ${q.sortCategory}' + ' sort order  ${q.sortOrder}');
  String finalStr = _initialStatements + getWhere(_filters) + orderBy();
  return finalStr;
}
