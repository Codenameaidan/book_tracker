import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/book.dart';
import '../viewmodels/book_view_model.dart';
import '../viewmodels/search_view_model.dart';

class SearchView extends StatelessWidget {
  final String data;

  SearchViewModel searchViewModel;

  SearchView(this.data, this.searchViewModel);

  @override
  Widget build(BuildContext context) {


    final myController = TextEditingController();
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
                    Row(
                      children: [
                        Column(children: [Image.network(book.coverUrl)],),
                        Column(children: [Text(book.title), Text(book.author),],)
                      ],

                    ),
                  );
                  results.add(
                    const Padding(padding: EdgeInsets.only(top: 16))
                  );
                });

                return Scaffold (
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