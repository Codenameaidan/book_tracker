import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../viewmodels/book_view_model.dart';
import '../viewmodels/search_view_model.dart';

class SearchView extends StatelessWidget {
  final String data;

  SearchViewModel searchViewModel;

  SearchView(this.data, this.searchViewModel);

  @override
  Widget build(BuildContext context) {

    
    
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
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Result: ${snapshot.data}'),
                ),
              ];
            }else{
              children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
            }
            
            return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
          }
        )
      )
    );
          /*
            child:ListView.builder(
        itemCount: this.searchViewModel.books.length,
        itemBuilder: (context, index) {

          final movie = this.searchViewModel.books[index];

          return ListTile(
            contentPadding: EdgeInsets.all(10),
            leading: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(movie.coverUrl)
                  ),
                  borderRadius: BorderRadius.circular(6)
              ),
              width: 50,
              height: 100,
            ),
            title: Text(movie.title),
          );
        },
      ))
    );
*/
  }
}