
import 'package:flutter/material.dart';
import '../services/web_service.dart';
import 'book_view_model.dart';

class SearchViewModel extends ChangeNotifier {

  List<BookViewModel> books = <BookViewModel>[];

  Future<void> fetchBooks(String keyword) async {
    final results =  await Webservice().fetchBooks(keyword);
    books = results.map((item) => BookViewModel(book: item)).toList();
    notifyListeners();
  }

}