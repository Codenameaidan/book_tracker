import 'package:flutter/material.dart';
import 'package:reading_tracker/models/book.dart';

/* 
* To Be Read Reading View Model: list of books 
* HAS: add book to list + remove book from list
* USED FOR: To Be Read reading view  
* NEEDS: book view model 
*/


// A list of books for now
final List<Book> initialData = List.generate(
    10,
        (index) => Book(
        id: index,
        title: "Title2",
        author: "Author2",
        totalPages: 300,
        ));

class ToBeReadViewModel with ChangeNotifier {

  final List<Book> _tobeList = initialData; //change 

  List<Book> get tobeList => _tobeList;

  void addToList(Book book) {
    _tobeList.add(book);
    notifyListeners();
  }

  void removeFromList(Book book) {
    _tobeList.remove(book);
    notifyListeners();
  }
}