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
  Future<Map> getMap() async {
    var mapOfInitialVals = Map();
    mapOfInitialVals['count'] = await config.loadCounterData();
    mapOfInitialVals['boolCheck'] = await config.loadBool();
    return mapOfInitialVals;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMap(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container(); //replace with loading screen
        } else {
          print('snapshot: ${snapshot.data["count"]}');
          print('snapshot: ${snapshot.data["boolCheck"]}');
          return MultiBlocProvider(
              providers: [
                BlocProvider<CounterBloc>(
                  create: (context) => CounterBloc(snapshot.data['count']),
                ),
                BlocProvider<ThemeBloc>(
                  create: (context) => ThemeBloc(snapshot.data['boolCheck']),
                )
              ],
              child: MaterialApp(
                home: Home(),
              ));

          // BlocProvider(
          //     create: (context) => CounterBloc(snapshot.data["count"]),
          //     child: MaterialApp(
          //       home: Home(),
          //       //TODO: here
          //     ));
        }
      },
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    assert(counterBloc != null); // ounterBloc should not be null
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.wb_sunny,
              color: Colors.blue,
            ),
            onPressed: () {
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
