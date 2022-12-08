import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_tracker/views/currently_reading_view.dart';
import '../constants.dart';
import '../models/book.dart';
import '../services/settings_controller.dart';
import '../viewmodels/book_view_model.dart';
import '../viewmodels/search_view_model.dart';
import 'book_view.dart';

class SearchView extends StatelessWidget {

  final String data;
  SearchViewModel searchViewModel;

  SearchView(this.data, this.searchViewModel);

  @override
  Widget build(BuildContext context) {


    final myController = TextEditingController(text: data);

    return Scaffold(

      body: Center(
        
        child: FutureBuilder(
          future: searchViewModel.fetchBooks(data),


          builder: (BuildContext context, AsyncSnapshot<List<BookViewModel>> snapshot)
          {
                if (snapshot.hasData) {

                  var results = <Widget>[];

                  //Build Layout for each Search Result
                  snapshot.data!.forEach((book) {
                    results.add(
                    SizedBox(
                      height: 300.0,
                      child: Card(
                        color: SettingsController.background1,
                        child:Row(
                          children: <Widget>[
                            Expanded(
                              flex: 5, // 50%
                              child:  ClipRRect (
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(book.coverUrl, fit: BoxFit.contain)
                              )
                            ),
                            Expanded(
                              flex: 5, // 50%
                              child: Padding(
                                padding: const EdgeInsets.only(top:20.0, right: 10.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Text(
                                          style: TextStyle(fontSize: 22, color: SettingsController.foreground),
                                          textAlign: TextAlign.center,
                                          book.title
                                      )
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child:  Text(
                                        "By ${book.author}",
                                        style: TextStyle(fontSize: 18, color: SettingsController.foreground),
                                        textAlign: TextAlign.center,
                                        )
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child:  Padding (
                                        padding: EdgeInsets.only(bottom: 15),
                                        child: Card(
                                          color: SettingsController.background2,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              textStyle: const TextStyle(fontSize: 20),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) => new BookView(book)),
                                                );
                                            },
                                            child: const Text('View'),
                                          ),
                                        )
                                      )

                                    ),
                                ]
                              ),
                              )
                            ),

                          ],
                        ))));
                  });


                  return Scaffold (
                    appBar: AppBar(
                      title: TextFormField(
                      controller: myController,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                      ),
                      onEditingComplete:() {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, searchRoute, arguments: myController.text);
                      },
                      )
                    ),
                    body: ListView(
                          children: results
                        )

                  );

              }
              else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      ),
                      SizedBox(
                        child: Card(
                          color: SettingsController.background1,
                          child:  TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                        ),
                      ),
                    ]
                  )
                );
              }


          })));
  }
}