import 'package:flutter/material.dart';
import 'package:note/screens/edit_notes.dart';
import 'package:note/screens/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteItHomePageScreen extends StatefulWidget {
  @override
  _NoteItHomePageScreenState createState() => _NoteItHomePageScreenState();
}

class _NoteItHomePageScreenState extends State<NoteItHomePageScreen> {
  Color _frameColor = Colors.white;
  Color _textColor = Colors.black;
  Color _cardColor = Colors.white;
  //get darkmode from disk
  Future<bool> _loadDarkModeBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('key_for_darkmode') ?? false;
  }

  setDardkModeVariablesHome() {
    _loadDarkModeBool().then((value) {
      setState(() {
        if (value == true) {
          this._frameColor = Colors.black;
          this._textColor = Colors.white;
          this._cardColor = Colors.black;
        } else {
          this._frameColor = Colors.white;
          this._textColor = Colors.black;
          this._cardColor = Colors.white;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setDardkModeVariablesHome();

    //SettingsScreenState.setDarkModeVariables();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: this._frameColor,
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        child: Icon(
          Icons.add,
          color: Colors.blueAccent,
        ),
        backgroundColor: this._frameColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditNoteScreen()));
        },
      ),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: this._frameColor,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
        title: Text(
          'Notes',
          style: TextStyle(color: this._textColor, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()));
              },
              icon: Icon(
                Icons.settings,
                color: Colors.blueAccent,
              ))
        ],
      ),
    );
  }
}
