import 'dart:ui';
import 'package:flutter/material.dart';

//Routing
const String homeRoute = '/currentlyReading';
const String searchRoute = '/search';
const String toBeReadRoute = '/toBeRead';
const String haveReadRoute = '/haveRead';
const String settingsRoute = '/settings';

//Dark Mode colors
const darkBackground1 =  Color.fromARGB(255, 71, 71, 71);
const darkBackground2 = Color.fromARGB(255, 54, 54, 54);
const darkForeground = Colors.white;

//Light Mode colors
const lightBackground1 =  Color.fromARGB(255, 244, 244, 244);
const lightBackground2 = Color.fromARGB(255, 186, 186, 186);
const lightForeground = Color.fromARGB(255, 24, 24, 24);

//Universal colors
const ruby =  Color.fromARGB(255, 232, 23, 93);
const lightRuby =  Color.fromARGB(255, 204, 82, 122);
const lightGray =  Color.fromARGB(255, 168, 167, 167);
const darkPurple = Color.fromARGB(255, 103, 58, 183);
const MaterialColor rubySwatch = MaterialColor(
    0xffe8175d,
    <int, Color>{
       50: Color(0xffef5d8e),
      100: Color(0xffed457d),
      200: Color(0xffea2e6d),
      300: Color(0xffe8175d),
      400: Color(0xffd11554),
      500: Color(0xffba214a),
      600: Color(0xffa21041),
      700: Color(0xffa21041),
      800: Color(0xffa21041),
      900: Color(0xffa21041),
    },
  );