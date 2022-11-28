import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/book.dart';
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
    //searchViewModel.fetchBooks(data);//.then((value) => print("TEST"+searchViewModel.books.toString()));

    return Scaffold(
      /*body: Center(
        child: Row(
          children: searchViewModel.books.map((word)=> Text(word.title)).toList()
        ),
      )*/

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
                      
                    child:Row(
                      children: <Widget>[
                        Expanded(
                          flex: 5, // 50%
                          child: Image.network(book.coverUrl),
                        ),
                        Expanded(
                          flex: 5, // 50%
                          child: Padding(
                            padding: EdgeInsets.only(top:20.0, right: 10.0),
                            child: Column(
                              
                              children: [
                                Expanded(
                                  flex: 3, // 50%
                                  child: Text(
                                      style: TextStyle(fontSize: 24),
                                      book.title
                                  )
                                ),
                                Expanded(
                                  flex: 2, // 50%
                                  child:  Text("By " + book.author)
                                ),
                                Expanded(
                                  flex: 2, // 50%
                                  child:  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: const TextStyle(fontSize: 20),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => new BookView(book)),
                                        );
                                    },
                                  //ontap close},
                                    child: const Text('View'),
                                  ),

                                ),
                            ]
                          ),
                          )
                          //child: Container(color: Colors.green),
                        ),
                       
                      ],
                    ))));
                });
                    /*SizedBox(
                    height: 300.0,
                    child: Card(
                      child:Row(
                        children: [
                          Image.network(book.coverUrl),
                          Column(
                            children: [
                            
                                Text(
                                    style: TextStyle(fontSize: 24),
                                    book.title
                                )
                              
                              , Text(book.author)
                            ]
                          ),
                          
                          
                        ],

                    )
                  )));
                  results.add(
                    const Padding(padding: EdgeInsets.only(top: 16))
                  );
                });*/

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
                    children: const <Widget>[
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      ),
                    ]
                  )
                );
              }


          })));
  }
}