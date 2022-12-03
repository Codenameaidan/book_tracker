import 'package:flutter/widgets.dart';
import '../models/book.dart';
import '../services/library_repository.dart';


class HaveReadViewModel with ChangeNotifier {

  // Currently reading books that will be shown on the currently reading screen
  final List<Book> _haveReadList = LibraryRepository().completedReading;

  // method to Retrieve currently reading books
   List<Book> get haveReadList => _haveReadList;

  // Adding a book to the current reading list
  void addToList(Book book) {
    _haveReadList.add(book);
    notifyListeners();
  }

  // Removing a book from the current reading list
  void removeFromList(Book book) {
    _haveReadList.remove(book);
    notifyListeners();
  }
}