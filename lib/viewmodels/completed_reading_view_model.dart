import 'package:flutter/widgets.dart';
import '../models/book.dart';

/*
* Completed Reading View Model: list of books
* HAS: add book to list + remove book from list
* USED FOR: Completed reading view
* NEEDS: book view model
*/


// A list of books for now

class CompReadViewModel with ChangeNotifier {

  final List<Book> _compList = []; //change

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