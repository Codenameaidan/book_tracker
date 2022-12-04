import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class SettingsController{

  static Color background1 = darkBackground1;
  static Color background2 = darkBackground2;
  static Color foreground = darkForeground;

  static Future<void> UpdateColorScheme() async{
    var pref = await SharedPreferences.getInstance();

    if(pref.getBool('lightMode') ?? false){ //Light Mode
        background1 = lightBackground1;
        background2 = lightBackground2;
        foreground = lightForeground;
    }else{ //Dark mode
        background1 = darkBackground1;
        background2 = darkBackground2;
        foreground = darkForeground;
    }
  }  

}