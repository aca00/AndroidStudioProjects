import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thisDay/config/bloc/change_bloc.dart';
import 'package:thisDay/config/bloc/config_bloc.dart';
import 'package:thisDay/config/bloc/month_bloc.dart';
import 'package:thisDay/config/date_time_data.dart';
import 'package:thisDay/config/user_preferences.dart';
import 'package:thisDay/screens/monthScreen.dart';
import 'package:thisDay/config/theme/bloc/theme_bloc.dart';

//// edit Alert must be replaced with Universal.editAlert
/// delete unwanted codes, comments
/// Add comments for future use
//// add goto screen
/// back up code to github
/// bug fix in note screen
//// upgrade universal edit screen for universal  queries

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<Map> getInitialVals() async {
    Map initVals = Map();
    initVals['darkMode'] = await loadDarkModeBool();
    initVals['accentColor'] = await loadAccentColorCount();
    initVals['month'] = getMonth();
    return initVals;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getInitialVals(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        }

        return MultiBlocProvider(
            providers: [
              BlocProvider<UpdateEventsInsideStoryBloc>(
                create: (context) => UpdateEventsInsideStoryBloc(),
              ),
              BlocProvider<ThemeBloc>(
                  create: (context) => ThemeBloc(
                      darkBoolCheck: snapshot.data['darkMode'],
                      accentColorCount: snapshot.data['accentColor'])),
              BlocProvider<ConfigBloc>(
                create: (context) => ConfigBloc(),
              ),
              BlocProvider<MonthBloc>(
                create: (context) => MonthBloc(month: snapshot.data['month']),
              )
            ],
            child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: MonthScreen(),
                  theme: state.themeData,
                );
              },
            ));
      },
    );
  }
}
