import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test4/bloc/counter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: BlocProvider(
            create: (BuildContext context) => CounterBloc(),
            child: MyHomePage()),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: Text('Sample'),
      ),
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  'Count value: ',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Center(
                child: Text(
                  'Message:',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              SizedBox(
                height: 17,
              ),
              Center(
                child: Text(
                  'Sample Message:\n $state',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              _counterBloc.add(CounterIncrementEvent());
            },
          ),
          FloatingActionButton(
            child: Icon(Icons.remove),
            onPressed: () {
              _counterBloc.add(CounterDecrementEvent());
            },
          )
        ],
      ),
    );
  }
}
