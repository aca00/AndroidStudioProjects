import 'package:flutter/material.dart';

import 'preference.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PreferencePage()));
            },
          )
        ],
      ),
      body: Center(
        child: Text(
          'Hi',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
