import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:thisDay/config/bloc/change_bloc.dart';
import 'package:thisDay/config/entry.dart';
import 'package:thisDay/config/theme_data.dart';
import 'package:thisDay/screens/goToScreen.dart';
import 'package:thisDay/screens/monthScreen.dart';
import 'package:thisDay/screens/universalWidgets.dart';
import 'package:thisDay/screens/yearScreen.dart';

class UniversalEditScreen extends StatelessWidget {
  // all entries are dynamic for some reason.
  final _dy;
  final int
      _mnth; // month number dynamic. Need to convert to int for other operations
  final _appBarTitle; // app bar title of universalEditScreen
  final _year;
  final _stryId;
  final _queryCode; // check which query to be executed for this screen
  final _storyName; // used to pass back to yearScreen of story
  final _rawquery;

  /// query codes
  /// 1. Queries required for yearScreen
  /// 2. Queries required for monthScreen

  UniversalEditScreen(this._appBarTitle,
      [this._dy,
      this._mnth,
      this._year,
      this._stryId,
      this._queryCode,
      this._storyName,
      this._rawquery]);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _backButton(context);
        return null;
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  _backButton(context);
                }),
            title: Text(_appBarTitle),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              UniversalWidget.addEventBottomSheet(
                  context: context,
                  entry: Entry(
                    0, //prioriry
                    this._stryId, // parentid
                    null, // title
                    this._year, // year
                    this._mnth, // month
                    this._dy, // day
                    null, // description
                  ));
            },
          ),
          body: BlocBuilder<UpdateEventsInsideStoryBloc,
              UpdateEventsInsideStoryState>(
            builder: (context, state) {
              return FutureBuilder(
                future: getListOfUniversalQuery(
                    queryCode: this._queryCode,
                    day: this._dy,
                    monthNumber: this._mnth,
                    changeCheck: state.check,
                    storyId: this._stryId,
                    year: this._year,
                    universalQuery: _rawquery),
                // getListOfEventsAtDayToEdit(
                //     day: this._dy,
                //     monthNum: this._mnth,
                //     changeCheck: state.check,
                //     yearEdit: this._yearEdit,
                //     storyId: this._stryId,
                //     year: this._year),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(child: Text('loading'));
                  }
                  final List _entryList = snapshot.data;

                  return ListView.builder(
                      itemCount: _entryList.length,
                      itemBuilder: (BuildContext context, int i) {
                        final _entry = _entryList[i];
                        final _dyName = _entry.day ?? ' ';
                        final _mnthName = _entry.monthName ?? '';
                        final _year = _entry.year ?? '  ';

                        return ListTile(
                          onTap: () {
                            UniversalWidget.addEventBottomSheet(
                                context: context, entry: _entry);
                          },
                          title: Text(_entry.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Day: $_dyName Month: $_mnthName Year: $_year'),
                              Text('Note:- ${_entry.description ?? ''}')
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: getPriorityColor(_entry.priority),
                            ),
                            onPressed: () {
                              UniversalWidget.addDeleteConfirmationAlert(
                                  context: context,
                                  entry: _entry,
                                  checkStory: null);
                            },
                          ),
                        );
                      });
                },
              );
            },
          )),
    );
  }

  void _backButton(BuildContext context) {
    if (this._queryCode == 1) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => YearScreen(this._storyName, this._stryId)));
    } else if (this._queryCode == 2) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MonthScreen()));
    } else if (this._queryCode == 3) {
      Navigator.pop(context);
    } else if (this._queryCode == 4) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MonthScreen()));
    }
  }
}
