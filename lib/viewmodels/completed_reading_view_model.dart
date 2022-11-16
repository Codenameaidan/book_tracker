import 'package:flutter/material.dart';
import 'package:reading_tracker/models/book.dart';

/* 
* Completed Reading View Model: list of books 
* HAS: add book to list + remove book from list
* USED FOR: Completed reading view  
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

class CompReadViewModel with ChangeNotifier {

  final List<Book> _compList = initialData; //change 

  List<Book> get compList => _compList;

  void addToList(Book book) {
    _compList.add(book);
    notifyListeners();
  }

  void removeFromList(Book book) {
    _compList.remove(book);
    notifyListeners();
  }
}