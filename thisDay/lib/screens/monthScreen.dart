import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:thisDay/config/bloc/month_bloc.dart';
import 'package:thisDay/config/bloc/change_bloc.dart';
import 'package:thisDay/config/date_time_data.dart';
import 'package:thisDay/config/entry.dart';
import 'package:thisDay/screens/goToScreen.dart';
import 'package:thisDay/screens/settings.dart';
import 'package:thisDay/screens/storyScreen.dart';
import 'package:thisDay/screens/universalEditScreen.dart';
import 'package:thisDay/screens/universalWidgets.dart';

class MonthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final monthBloc = BlocProvider.of<MonthBloc>(context);
    final drawerItems = ListView(
      children: [
        ListTile(
          leading: Icon(Icons.call_made, size: 20),
          title: Text('Go to'),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return BlocProvider(
                create: (context) => ChangeBloc(sortCategory: 0, sortOrder: 0),
                child: GoToScreen(),
              );
            }));
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.category, size: 20),
          title: Text('Stories'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return BlocProvider<UpdateEventsInsideStoryBloc>(
                create: (context) => UpdateEventsInsideStoryBloc(),
                child: StoryScreen(),
              );
            }));
          },
        ),
        ListTile(
          leading: Icon(Icons.note, size: 20),
          title: Text('Drafts'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return BlocProvider<UpdateEventsInsideStoryBloc>(
                create: (context) => UpdateEventsInsideStoryBloc(),
                child: UniversalEditScreen('Drafts', null, null, null, null, 4),
              );
            }));
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.settings,
            size: 20,
          ),
          title: Text('Settings'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingScreen(),
                ));
          },
        ),
      ],
    );

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: BlocBuilder<MonthBloc, MonthState>(
            builder: (context, state) {
              return _buildDropdownButton(state, monthBloc);
            },
          ),
        ),
        body: BlocBuilder<MonthBloc, MonthState>(
          builder: (context, state) {
            final int _monthNum = state.numMonth;
            final String _monthName = monthList[_monthNum - 1];

            // Dates of month in which event is created

            return FutureBuilder(
              future: getDatesOfMonthList(mnth: '$_monthNum'),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(child: Text('Loading'));
                }
                return _buidBody(context,
                    listOfDates: snapshot.data,
                    monthName: _monthName,
                    monthNum: _monthNum);
              },
            );
          },
        ),
        drawer: Drawer(
          elevation: 0,
          child: drawerItems,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            UniversalWidget.addEventBottomSheet(
                context: context, entry: Entry(0));
          },
          child: Icon(Icons.add),
        ));
  }

  DropdownButton<String> _buildDropdownButton(
      MonthState state, MonthBloc monthBloc) {
    return DropdownButton(
        items: dropDownMonths,
        value: monthList[state.numMonth - 1],
        onChanged: (val) {
          monthBloc.add(MonthChangeEvent(monthList.indexOf(val) + 1));
        });
  }

  ListView _buidBody(BuildContext context,
      {List listOfDates, String monthName, int monthNum}) {
    final List _listOfDates = listOfDates;
    return ListView.builder(
        itemCount: _listOfDates.length,
        itemBuilder: (BuildContext context, int i) {
          final dynamic _day = _listOfDates[i];
          //final String _mnthNum = monthNum.toString();
          return buildCard(context,
              day: _day, monthNum: monthNum, monthName: monthName);
        });
  }

  FutureBuilder buildCard(BuildContext context,
      {dynamic day, int monthNum, String monthName}) {
    return FutureBuilder(
        future:
            listOfEventsAtDay(context, day: day.toString(), monthNum: monthNum),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Text('Loading');
          }

          return Column(
            children: [
              Text('\n${day ?? ''} $monthName',
                  style: TextStyle(color: Colors.grey)),
              Card(
                  elevation: 0,
                  child: ListTile(
                      onLongPress: () {
                        UniversalWidget.addEditAlert(
                            context: context,
                            appBarTitle: '${day ?? ''} $monthName',
                            queryDay: day,
                            queryMonth: monthNum,
                            queryCode: 2);
                        // var wid = UniversalWidget();
                        // wid.editAlert(
                        //   context: context,
                        //   appBarTitle: '${day ?? ''} $monthName',
                        //   queryDay: day,
                        //   queryMonth: monthNum,
                        // );
                      },
                      title: RichText(
                        text: TextSpan(children: snapshot.data),
                      ))),
            ],
          );
        });
  }
}
