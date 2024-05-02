import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class weatherProvider with ChangeNotifier{

  weatherProvider(){}

  bool isTheme = false;
  bool tempUnit = false;

  // var data = searchList;
  set setTheme(value){
    isTheme = value;
    notifyListeners();
  }

  get getTheme{
    return isTheme;
  }

  setThemeSharePrefrence(value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('Theme', value);
  }

  getThemeSharePrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isTheme = pref.getBool('Theme') ?? false;
  }

}