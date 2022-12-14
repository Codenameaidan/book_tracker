import 'package:flutter/widgets.dart';
import '../models/book.dart';
import '../services/library_repository.dart';


class ToBeReadViewModel with ChangeNotifier {

  // Currently reading books that will be shown on the currently reading screen
  final List<Book> _tobeList = LibraryRepository().toBeRead;

  // method to Retrieve currently reading books
   List<Book> get tobeList => _tobeList;

  // Adding a book to the current reading list
  void addToList(Book book) {
    _tobeList.add(book);
    notifyListeners();
  }

  // Removing a book from the current reading list
  void removeFromList(Book book) {
    _tobeList.remove(book);
    notifyListeners();
  }
}