import 'dart:ffi';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:note/screens/aboutUs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:note/screens/noteitHomePage.dart';

class SettingsScreen extends StatefulWidget {
  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  bool _switchDark = false;

  Color _frameColor = Colors.white;
  Color _textColor = Colors.black;
  Color _cardColor = Colors.white;

  int accentColorCount = 0;
  int textSizeCount = 0;

  List<Color> accentColors = [
    Colors.blueAccent,
    Colors.redAccent,
    Colors.lightGreen,
    Colors.yellow
  ];
  List<String> textSizes = ['Small', 'Medium', 'Large'];

  //save darkmode settings to storage. It returns a bool if the save was successful
  Future<bool> _saveDarkModeSettings(switchVal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool('key_for_darkmode', switchVal);
  }

  //load darkmode settings from storage. It returns whatever saved in the storage
  // in this case it is bool
  Future<bool> _loadDarkModeSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('key_for_darkmode') ?? false;
  }

  //setting value of variable. This includes the themedata. It get refreshed as
  //function called. value in then(value) is the output from _loadDarkmodeSettings
  //In this case it is boolean
  void setDarkModeVariables() {
    _loadDarkModeSettings().then((value) {
      setState(() {
        this._switchDark = value;
        if (_switchDark == true) {
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

  //function that set dark mode
  _gotoDarkMode(bool switchVal) {
    _saveDarkModeSettings(switchVal).then((value) {
      if (value == true) {
        setDarkModeVariables();
      }
    });
  }

  //AccentColorCount is use to select an accentColor form list of colors.
  //Following function saves accentColorCount in disk.
  Future<bool> _saveAccentColorCount(accentColorCount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setInt('key_for_accentColorCount', accentColorCount);
  }

  //load accentcolorcount from disk. Return type is int
  Future<int> _loadAccentColorCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('key_for_accentColorCount') ?? 0;
  }

  //setAccentColorCount a value by default. This is called along with initState()
  _setAccentColorCount() {
    _loadAccentColorCount().then((value) {
      setState(() {
        this.accentColorCount = value;
      });
    });
  }

  //This function first load data which is an int and update state with increased
  //accentColorCount
  _increaseAccentColorCountOnPressed() {
    _loadAccentColorCount().then((value) {
      setState(() {
        this.accentColorCount = value;
        if (this.accentColorCount >= 3) {
          accentColorCount = 0;
        } else {
          accentColorCount++;
        }
        _saveAccentColorCount(accentColorCount);
      });
    });
  }

  //TexttSizecount is used to select appropriate textsize from list of textsizes
  //This function saves textSizeCount into disk
  Future<bool> _saveTextSizeCount(textSizeCount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setInt('key_for_textSize', textSizeCount);
  }

  //load textSize count from disk
  Future<int> _loadTextSizeCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('key_for_textSize') ?? 0;
  }

  //increase textSizecount on pressed
  _increseTextSizeCountOnPressed() {
    _loadTextSizeCount().then((value) {
      setState(() {
        this.textSizeCount = value;
        if (textSizeCount >= 2) {
          textSizeCount = 0;
        } else {
          textSizeCount++;
        }
        _saveTextSizeCount(textSizeCount);
      });
    });
  }

  //set initial value for textSizecount
  _setTextSizeCount() {
    _loadTextSizeCount().then((value) {
      setState(() {
        this.textSizeCount = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setDarkModeVariables();
    _setAccentColorCount();
    _setTextSizeCount();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: this._frameColor,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0.0,
              backgroundColor: this._frameColor,
              snap: false,
              floating: true,
              pinned: true,
              expandedHeight: 120.0,
              leading: IconButton(
                  icon: Icon(
                    Icons.info,
                    color: accentColors[accentColorCount],
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AboutUsScreen(
                                  this._frameColor,
                                  this._textColor,
                                  accentColors[accentColorCount],
                                  this._cardColor,
                                )));
                  }),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NoteItHomePageScreen()));
                  },
                  icon: Icon(
                    Icons.library_books,
                    color: this.accentColors[accentColorCount],
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  'Settings',
                  style: TextStyle(
                    color: this._textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.wb_sunny,
                        color: this._frameColor,
                      ),
                      backgroundColor: this._textColor,
                    ),
                    title: Text(
                      'Dark mode',
                      style: TextStyle(color: this._textColor),
                    ),
                    trailing: Switch(
                      value: this._switchDark,
                      onChanged: (bool switchVal) {
                        _gotoDarkMode(switchVal);
                      },
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      _increaseAccentColorCountOnPressed();
                    },
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.color_lens,
                        color: Colors.white,
                      ),
                      backgroundColor: accentColors[accentColorCount],
                    ),
                    title: Text(
                      'Accent color',
                      style: TextStyle(color: this._textColor),
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.text_format,
                        color: Colors.white,
                      ),
                      backgroundColor: accentColors[accentColorCount],
                    ),
                    title: Text(
                      'Text size',
                      style: TextStyle(color: this._textColor),
                    ),
                    trailing: Text(
                      '${textSizes[textSizeCount]}',
                      style: TextStyle(color: this._textColor),
                    ),
                    onTap: () {
                      _increseTextSizeCountOnPressed();
                    },
                  ),
                  SizedBox(height: 8.0),
                  Row(children: <Widget>[
                    Container(
                      //color: Colors.yellow,
                      padding: EdgeInsets.fromLTRB(10.0, 10, 5, 0),
                      child:
                          Text('Back up', style: TextStyle(color: Colors.grey)),
                    ),
                  ]),
                  SizedBox(
                    height: 8.0,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.cloud_circle,
                        color: Colors.white,
                      ),
                      backgroundColor: accentColors[accentColorCount],
                    ),
                    title: Text(
                      'Back up',
                      style: TextStyle(color: this._textColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
