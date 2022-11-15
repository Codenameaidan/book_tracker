
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reading_tracker/models/book.dart';

class Webservice {

  Future<List<Book>> fetchBooks(String term) async {

    String url = "http://openlibrary.org/search.json?q=${term}";
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {

      final body = jsonDecode(response.body);
      final Iterable json = body["docs"];
      return json.map((book) => Book.fromJson(book)).take(10).toList(); //currently limited to only first 10 results

    } else {
      throw Exception("Unable to perform request!");
    }
  }
}