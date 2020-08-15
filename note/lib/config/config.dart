import 'package:shared_preferences/shared_preferences.dart';

Config config = Config();

class Config {
  Future<bool> saveBool(val) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setBool('key_for_dark', val);
  }

  Future<bool> loadBool() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool('key_for_dark') ?? false;
  }
}
