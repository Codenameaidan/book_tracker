import 'package:flutter/widgets.dart';
import 'package:reading_tracker/services/library_repository.dart';
import '../models/book.dart';

/*
* Currently Reading View Model: list of books
* HAS: add book to list + remove book from list
* USED FOR: currently reading view
* NEEDS: book view model
*/


class CurrReadViewModel with ChangeNotifier {

  // Currently reading books that will be shown on the currently reading screen
  final List<Book> _currList = LibraryRepository().currentlyReading;

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