
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reading_tracker/models/book.dart';

class Webservice {

  Future<List<Book>> fetchBooks(String term) async {

    String url = "http://openlibrary.org/search.json?title=${term}";
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {

      final body = jsonDecode(response.body);
      Iterable json = body["docs"];
      json = json.take(5); //currently limited to only first 10 results
      return json.map((book) => Book.fromJson(book)).toList();

    } else {
      throw Exception("Unable to perform request!");
    }
  }
}