import 'package:shared_preferences/shared_preferences.dart';


final _pref = SharedPreferences.getInstance();

Future saveDarkModeBool(val) async {
  SharedPreferences pref = await _pref;
  return await pref.setBool('keyDark', val);
}

Future loadDarkModeBool() async {
  SharedPreferences pref = await _pref;
  return pref.getBool('keyDark') ?? false;
}

Future saveAccentInt(val) async {
  SharedPreferences pref = await _pref;
  return await pref.setInt('keyAccent', val);
}

Future loadAccentColorCount() async {
  SharedPreferences pref = await _pref;
  return pref.getInt('keyAccent') ?? 0;
}

