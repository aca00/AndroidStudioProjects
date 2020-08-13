import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Config {
  // ssaving counter value
  Future<bool> saveCounterData(int val) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setInt('key_for_counter', val);
  }

  // loading counter value
  Future<int> loadCounterData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt('key_for_counter') ?? 0;
  }

  Future<bool> saveBool() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setBool('key_for_theme', true);
  }

  Future<bool> loadBool() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool('key_for_theme') ?? false;
  }
}

enum AppThemes {
  light,
  dark,
}

final appThemeData = {
  AppThemes.light: ThemeData(
    brightness: Brightness.light,
  ),
  AppThemes.dark: ThemeData(
    brightness: Brightness.dark,
  )
};
