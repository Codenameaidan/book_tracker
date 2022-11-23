import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_tracker/services/library_repository.dart';

import '../constants.dart';
import '../viewmodels/book_view_model.dart';
import 'currently_reading_view.dart';


class BookView extends StatefulWidget {
  
  BookViewModel book;

  BookView(this.book);

  //const BookView({Key? key}) : super(key: key);

  @override
  _BookViewState createState() => _BookViewState();
}

final myController = TextEditingController();

class _BookViewState extends State<BookView>{
  @override
  Widget build(BuildContext context) {
    BookViewModel book = widget.book;

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
        body: Column(
          children:[
            Text(book.title),
            
            LibraryRepository().bookExistsInCurrent(book.book) ? 
            Text("Already in Current") :
            TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  LibraryRepository().addCurrentBook(book.book);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => new CurReadView(),
                    )
                  );
                },
              //ontap close},
                child: const Text('Add to Currently Reading'),
              ),
          ]
        )
    );
  }
}