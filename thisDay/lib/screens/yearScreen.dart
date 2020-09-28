import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thisDay/config/bloc/change_bloc.dart';
import 'package:thisDay/config/entry.dart';

import 'package:thisDay/screens/universalWidgets.dart';

class YearScreen extends StatelessWidget {
  final String _title;
  final int stryId;
  YearScreen(this._title, this.stryId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this._title ?? '')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          UniversalWidget.addEventBottomSheet(
              context: context,
              entry: Entry(
                0,
                this.stryId,
              ));
        },
      ),
      body: BlocBuilder<UpdateEventsInsideStoryBloc,
          UpdateEventsInsideStoryState>(
        builder: (context, state) {
          return FutureBuilder(
            future:
                getYearsOfStory(storyId: stryId, changeDetector: state.check),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Text('loading');
              }
              debugPrint(' data  : ${snapshot.data}');
              return _buildBody(listOfYears: snapshot.data);
            },
          );
        },
      ),
    );
  }

  Widget _buildBody({List listOfYears}) {
    return ListView.builder(
        itemCount: listOfYears.length,
        itemBuilder: (BuildContext context, int i) {
          return FutureBuilder(
            future: listOfEventsAtYear(context, listOfYears[i], this.stryId),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Text('Loading');
              }
              final _events = snapshot.data;

              final _yearBeta = listOfYears[
                  i]; // null is a valid value to pass to other screens
              final _year = _yearBeta ?? ''; // to display in app bar
              debugPrint('  year : ${_year}');
              return Column(
                children: [
                  Text(_year.toString()),
                  Card(
                    child: ListTile(
                      onLongPress: () {
                        UniversalWidget.addEditAlert(
                            context: context,
                            storyName: this._title ?? '',
                            appBarTitle: "($_year) $_title",
                            storyId: this.stryId,
                            queryYear: _yearBeta,
                            queryCode: 1);
                        // final wid = UniversalWidget();
                        // wid.editAlert(
                        //     storyName: this._title ?? '',
                        //     context: context,
                        //     appBarTitle: "($_year) $_title",
                        //     storyId: this.stryId,
                        //     queryYear: _yearBeta,
                        //     editYearCheck: true);
                      },
                      title: RichText(
                        text: TextSpan(children: _events),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        });
  }
}
