import 'dart:ui';

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
          children: [
            SizedBox(
              height: 200,
              child:
                Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(book.coverUrl, fit: BoxFit.cover),
                    ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: Colors.grey.withOpacity(0.1),
                          alignment: Alignment.center,
                          child: Padding (
                            padding: EdgeInsets.only(bottom: 10, top: 10),
                            child: ClipRRect (
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(book.coverUrl, fit: BoxFit.contain)
                            )
                          )
                        ),
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(
              height: 80,
              child: Text(
                book.title,
                style: const TextStyle(fontSize: 24, color: Colors. white70),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30,
              child: Text(
                "By ${book.author}",
                style: const TextStyle(fontSize: 18, color: Colors. white70),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 50,
              child: Text(
                "book.desc",
                style: const TextStyle(fontSize: 18, color: Colors. white70),
                textAlign: TextAlign.center,
              ),
            )
          ]
        )

    );
  }
}

/*
 LibraryRepository().bookExistsInCurrent(book.book) ? Text("Already in Current") :
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
                child: const Text('Add to Currently Reading'),
              ) */