import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_tracker/services/library_repository.dart';
import 'package:reading_tracker/services/web_service.dart';
import 'constants.dart';
import 'router.dart' as LocalRouter;
import 'models/book.dart';
import 'viewmodels/search_view_model.dart';
import 'views/search_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book App',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue
      ),
      onGenerateRoute: LocalRouter.Router.generateRoute,
      initialRoute: homeRoute,

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: TextFormField(
                  controller: myController,
                  decoration: const InputDecoration(
                  hintText: 'Search',
                  ),
                  onEditingComplete:() {
                      Navigator.pushNamed(context, searchRoute, arguments: myController.text);
                  },
            )
        ),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(title:const Text("Reading")),
                ListTile(title:const Text("Future Reading")),
                ListTile(title:const Text("Read")),
                ListTile(title:const Text("Settings")),
              ]
            )
          )

        )

    );
  }
}
