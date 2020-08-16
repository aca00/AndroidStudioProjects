import 'package:shared_preferences/shared_preferences.dart';

Config config = Config();

class Config {

  final _pref = SharedPreferences.getInstance();
  final List<String> textSizes = ['Small', 'Medium', 'Large'];

  //saving dark mode bool
  Future<bool> saveBool(val) async {
    SharedPreferences pref = await _pref;
    return await pref.setBool('key_for_dark', val);
  }

  //loading dark mode bool
  Future<bool> loadBool() async {
    SharedPreferences pref = await _pref;
    return pref.getBool('key_for_dark') ?? false;
  }

  Future<Map> getMapOfInitialVals() async {
    Map initailVals = Map();
    initailVals['checkDark'] = await loadBool();
    return initailVals;
  }
}
