import 'package:flutter/material.dart';
import 'package:reading_tracker/services/library_repository.dart';
import 'models/book.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue
      ),
      //i think this needs to be CurReadView() becasue that is our home page
      //uncomment when CurReadView is done
      //home: const CurReadView(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'), 
      
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: TextFormField(
                  decoration: const InputDecoration(
                  hintText: 'Search',
                  )
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