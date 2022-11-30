
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reading_tracker/models/book.dart';

class Webservice {

  Future<List<Book>> fetchBooks(String term) async {

    //String url = "http://openlibrary.org/search.json?title=${term}";
    String url = "https://www.googleapis.com/books/v1/volumes?q=$term&orderBy=relevance";

    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {

      final body = jsonDecode(response.body);
      Iterable json = body["items"];

      json = json.where((book) => book.containsKey("volumeInfo")).take(10); //currently limited to only first 10 results


      return json.map((book) => Book.fromJson(book)).toList();

    } else {
      throw Exception("Unable to perform request!");
    }
  }
}