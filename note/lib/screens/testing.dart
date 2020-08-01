import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestingScreen extends StatefulWidget {
  @override
  _TestingScreenState createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  int acccentColorCount = 0;
  List<Color> accentColors = [
    Colors.blueAccent,
    Colors.redAccent,
    Colors.lightGreen,
    Colors.yellow
  ];

  //save data
  Future<bool> saveData(number) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setInt('myKey', number);
  }

  //load data
  Future<int> loadData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt('myKey') ?? 0;
  }

  void increse() {
    loadData().then((value) {
      setState(() {
        this.acccentColorCount = value;
        if (acccentColorCount >= 3) {
          acccentColorCount = 0;
        } else {
          acccentColorCount++;
        }
        saveIncreasedvalue(this.acccentColorCount);
      });
    });
  }

  saveIncreasedvalue(int accentColorCount) {
    saveData(accentColorCount);
  }

  @override
  initState() {
    super.initState();
    loadData().then((value) {
      setState(() {
        this.acccentColorCount = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accentColors[acccentColorCount],
      body: Center(
          child: RaisedButton(
        onPressed: () {
          increse();
        },
        child: Text('Change Color'),
      )),
    );
  }
}
