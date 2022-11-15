import 'package:flutter/material.dart';
import 'dart:math';
import '../model/book_view_model.dart';

/* 
* Currently Reading View Model: list of books 
* HAS: add book to list + remove book from list
* USED FOR: currently reading view  
* NEEDS: book view model 
*/


// A list of books for now
final List<Book> initialData = List.generate(
    50,
        (index) => Book(
        id: "$index",
        title: "Title",
        author: "Author",
        totalPages: 300,
        ));

class CurrReadViewModel with ChangeNotifier {

  // Currently reading books that will be shown on the currently reading screen
  final List<Book> _currList = initialData; //change 

  // method to Retrieve currently reading books 
  List<Book> get currList => _currList;

  // Adding a book to the current reading list
  void addToList(Book book) {
    _currList.add(book);
    notifyListeners();
  }

  // Removing a book from the current reading list
  void removeFromList(Book book) {
    _currList.remove(book);
    notifyListeners();
  }
}