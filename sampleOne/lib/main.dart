import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sampleOne/bloc/counter_bloc.dart';
import 'package:sampleOne/theme/bloc/theme_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sampleOne/config/config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Config config = Config();
  Future<Map> getMapOfInitialVals() async {
    var mapOfInitialVals = Map();
    mapOfInitialVals['count'] = await config.loadCounterData();
    mapOfInitialVals['boolCheck'] = await config.loadBool();
    return mapOfInitialVals;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMapOfInitialVals(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container(); //replace with loading screen
        } else {
          print('snapshot count value: ${snapshot.data["count"]}');
          print('snapshot dark mode: ${snapshot.data["boolCheck"]}');
          return MultiBlocProvider(
              providers: [
                BlocProvider<CounterBloc>(
                  create: (context) => CounterBloc(snapshot.data['count']),
                ),
                BlocProvider<ThemeBloc>(
                  create: (context) => ThemeBloc(snapshot.data['boolCheck']),
                )
              ],
              child:
                  BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
                debugPrint('${state.myTheme}');
                return MaterialApp(
                  home: Home(),
                  theme: state.myTheme,
                );
              }));
        }
      },
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    assert(counterBloc != null); // ounterBloc should not be null
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.wb_sunny,
              color: Colors.blue,
            ),
            onPressed: () {
              themeBloc.add(ThemeChangedEvent());
              //swith to dark mode
            }),
      ),
      body: Center(
        child:
            BlocBuilder<CounterBloc, CounterState>(builder: (context, state) {
          return Text(
            'Count Value: ${state.countValue}',
            style: TextStyle(fontSize: 22),
          );
        }),
      ),
      floatingActionButton: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  counterBloc.add(CounterIncrementEvent(state.countValue));
                },
                child: Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: () {
                  counterBloc.add(CounterDecrementEvent(state.countValue));
                },
                child: Icon(Icons.remove),
              )
            ],
          );
        },
      ),
    );
  }
}
