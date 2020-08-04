import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '1',
          style: TextStyle(fontSize: 25),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
          ),
          FloatingActionButton(onPressed: () {}, child: Icon(Icons.remove)),
        ],
      ),
    );
  }
}
