import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

Stream<int> getNum() async* {
  for (int i = 1; i <= 3; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 3));
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentNumber;
  // @override
  // void initState() {
  //   getNum().listen((event) {
  //     setState(() {
  //       currentNumber = event;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<int>(
          stream: getNum(),
          builder: (context, snapshot) {
            return Center(
              child: Text(
                  snapshot.hasData ? snapshot.data.toString() : 'no data here'),
            );
          }),
    );
  }
}
