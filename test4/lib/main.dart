import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test4/config/database_helper.dart';
import 'package:test4/config/notes/bloc/note_bloc.dart';

import 'package:test4/config/theme/bloc/theme_bloc.dart';
import 'package:test4/screens/home.dart';

import 'config/user_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<List> getDb() async {
    return DatabaseHelper.instance.queryAll();
  }

  Future<Map> getInitialValuesToStartApp() async {
    Map initVal = Map();
    initVal['db'] = await getDb(); //list of maps
    initVal['numOfItems'] = initVal['db'].length; // no of items
    initVal['dark'] = await loadDarkModeBool();
    initVal['accent'] = await loadAccentColorCount();
    return initVal;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getInitialValuesToStartApp(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        }
        debugPrint('db : ${snapshot.data['numOfItems']}');
        return MultiBlocProvider(
          providers: [
            BlocProvider<ThemeBloc>(
                create: (context) => ThemeBloc(
                    darkBoolCheck: snapshot.data['dark'],
                    accentColorCount: snapshot.data['accent'])),
            BlocProvider<NoteBloc>(
                create: (context) => NoteBloc(
                    db: snapshot.data['db'],
                    itemCount: snapshot.data['numOfItems']))
          ],
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: state.themeData,
                home: BlocBuilder<NoteBloc, NoteState>(
                  builder: (context, state) {
                    return HomeScreen();
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
