import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/screens/edit_notes.dart';
import 'package:note/screens/testing.dart';
import 'package:flutter/material.dart';
import 'package:note/screens/settings.dart';
import 'package:note/screens/aboutUs.dart';
import 'package:note/screens/noteitHomePage.dart';
import 'package:note/theme/bloc/theme_bloc.dart';

import 'config/config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<Map> getMapOfInitialVals() async {
    Map initailVals = Map();
    initailVals['checkDark'] = await config.loadBool();
    return initailVals;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMapOfInitialVals(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        } else {
          debugPrint('snapshot dark mode: ${snapshot.data['checkDark']}');
          return MultiBlocProvider(
              providers: [
                BlocProvider<ThemeBloc>(
                  create: (context) => ThemeBloc(snapshot.data['checkDark']),
                )
              ],
              child: BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  return MaterialApp(
                    home: NoteItHomePageScreen(),
                    theme: state.appTheme,
                  );
                },
              ));
        }
      },
    );

    // return MaterialApp(

    //   debugShowCheckedModeBanner: false,
    //   home: NoteItHomePageScreen(),
    // );
  }
}
