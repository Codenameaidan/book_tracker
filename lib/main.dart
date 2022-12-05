import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_tracker/services/settings_controller.dart';
import 'package:reading_tracker/viewmodels/have_read_view_model.dart';
import 'package:reading_tracker/viewmodels/to_be_read_view_model.dart';
import 'services/library_repository.dart';
import 'services/web_service.dart';
import 'constants.dart';
import 'router.dart' as LocalRouter;
import 'models/book.dart';
import 'viewmodels/search_view_model.dart';
import 'views/search_view.dart';
import 'views/currently_reading_view.dart';
import 'viewmodels/currently_reading_view_model.dart';



void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await LibraryRepository().load();

  await SettingsController.UpdateColorScheme();

  runApp(
  MultiProvider(
  providers: [
    ChangeNotifierProvider<CurrReadViewModel>(create: (_) => CurrReadViewModel()),
    ChangeNotifierProvider<HaveReadViewModel>(create: (_) => HaveReadViewModel()),
    ChangeNotifierProvider<ToBeReadViewModel>(create: (_) => ToBeReadViewModel()),
  ],
  child: const MyApp(),
)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book App',
      theme: ThemeData(
        primarySwatch: rubySwatch,
        scaffoldBackgroundColor:SettingsController.background2,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: LocalRouter.Router.generateRoute,
      initialRoute: homeRoute,

    );
  }
}
