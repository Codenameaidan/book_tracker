import 'package:flutter/material.dart';
import 'package:reading_tracker/viewmodels/search_view_model.dart';
import 'constants.dart';
import 'views/currently_reading_view.dart';
import 'views/search_view.dart';

class Router {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const CurReadView());
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