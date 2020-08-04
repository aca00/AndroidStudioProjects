import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test2/counterBloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: BlocProvider(
              create: (BuildContext context) => CounterBloc(),
              child: CounterScreen()),
        ));
  }
}

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _counterBloc = BlocProvider.of<CounterBloc>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          BlocBuilder<CounterBloc, int>(
              builder: (BuildContext context, int state) {
            return Text(
              'value: $state',
              style: TextStyle(fontSize: 26),
            );
          }),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  _counterBloc.add(CounterEvents.increment);
                },
                child: Text('Increase'),
              ),
              SizedBox(
                width: 5,
              ),
              RaisedButton(
                onPressed: () {
                  _counterBloc.add(CounterEvents.decrement);
                },
                child: Text('Decrease'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
