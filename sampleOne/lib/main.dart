import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sampleOne/bloc/counter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(create: (context) => CounterBloc(), child: Home()),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    assert(counterBloc != null); // ounterBloc should not be null
    return Scaffold(
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
