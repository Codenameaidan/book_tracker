import 'package:flutter/material.dart';
import 'package:reading_tracker/viewmodels/search_view_model.dart';
import 'package:reading_tracker/views/have_read_view.dart';
import 'package:reading_tracker/views/to_be_read_view.dart';
import 'constants.dart';
import 'views/currently_reading_view.dart';
import 'views/search_view.dart';
import 'views/settings_view.dart';

class Router {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const CurReadView());
      case toBeReadRoute:
        return MaterialPageRoute(builder: (_) => const ToBeReadView());
      case haveReadRoute:
        return MaterialPageRoute(builder: (_) => const HaveReadView());
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsView());
      case searchRoute:
        var data = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => SearchView(data, SearchViewModel()));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}