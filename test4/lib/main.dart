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
  int _count = 0;
  Color asd = Colors.orange;

  @override
  Widget build(BuildContext context) {
    final _counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.wb_sunny),
          onPressed: () {
            //darkmodeOn
          },
        ),
        title: Text('Sample'),
      ),
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  'Count value: ${this._count}',
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
                child: BlocListener<CounterBloc, CounterState>(
                  listener: (context, state) {
                    if (state is CounterIncrementState) {
                      this.asd = Colors.green;
                      this._count = this._count + 1;
                      debugPrint('incremnt: ${this.asd}');

                      debugPrint("increment: $state");
                    }
                    if (state is CounterDecrementState) {
                      this.asd = Colors.indigo;
                      this._count = this._count - 1;
                      debugPrint('decrememt: ${this.asd}');

                      debugPrint("decrement: $state");
                    }
                  },
                  child: Text(
                    'Sample Message: \n $state',
                    style: TextStyle(fontSize: 12, color: this.asd),
                  ),
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
