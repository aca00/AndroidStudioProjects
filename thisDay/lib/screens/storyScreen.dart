import 'package:thisDay/config/bloc/change_bloc.dart';
import 'package:thisDay/config/entry.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thisDay/screens/monthScreen.dart';

import 'package:thisDay/screens/universalWidgets.dart';
import 'package:thisDay/screens/yearScreen.dart';

class StoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var _wid = UniversalWidget();
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
            },
          ),
          title: Text('Stories'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                UniversalWidget.addStoryBottomSheet(
                    context: context, entry: Entry(null, 0));
              },
            )
            ////_wid.addStoryButton(context: context, story: Entry(null, 0))
          ],
        ),
        body: BlocBuilder<UpdateEventsInsideStoryBloc,
            UpdateEventsInsideStoryState>(
          builder: (context, state) {
            return FutureBuilder(
              future: getStoryList(checkForStateChange: state.check),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Text('Loading');
                }
                final _storyList = snapshot.data;

                return _buidStoryScreenBody(_storyList);
              },
            );
          },
        ),
      ),
    );
  }

  void _backButton(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MonthScreen()));
  }

  Widget _buidStoryScreenBody(List<Entry> storyList) {
    return ListView.builder(
        itemCount: storyList.length,
        itemBuilder: (BuildContext context, int i) {
          final Entry _story = storyList[i];
          return Card(
            child: ListTile(
              leading: Icon(Icons.bubble_chart),
              title: Text(_story.title ?? ''),
              subtitle: Text(_story.description ?? ''),
              onLongPress: () {
                UniversalWidget.addEditDeleteAlert(
                    context: context, entry: _story);
              },
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BlocProvider<UpdateEventsInsideStoryBloc>(
                    create: (context) => UpdateEventsInsideStoryBloc(),
                    child: YearScreen(_story.title, _story.id),
                  );
                }));
              },
            ),
          );
        });
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
