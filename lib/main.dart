import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/library_repository.dart';
import 'services/web_service.dart';
import 'constants.dart';
import 'router.dart' as LocalRouter;
import 'models/book.dart';
import 'viewmodels/search_view_model.dart';
import 'views/search_view.dart';
import 'views/currently_reading_view.dart';
import 'viewmodels/currently_reading_view_model.dart';



void main() {
  runApp(ChangeNotifierProvider<CurrReadViewModel>(
    child: const MyApp(),
    create: (_) => CurrReadViewModel(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book App',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        scaffoldBackgroundColor: Color.fromARGB(255, 99, 99, 99)
      ),

      onGenerateRoute: LocalRouter.Router.generateRoute,
      initialRoute: homeRoute,

    );
  }
}
