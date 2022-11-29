import 'dart:ffi';

const notFoundImage = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/800px-Image_not_available.png?20210219185637";

enum Library{
    none,
    completed,
    reading,
    toBeRead
}

class Book {

  final String id;
  final String title;
  final String author;
  final String desc;
  final int totalPages;
  final double rating;
  final int numRatings;
  final String coverUrl;
  final String publisher;
  final String publishedDate;

  int currentPage = 0;
  String notes = "";
  Library library = Library.none;

  Book({required this.id, required this.title, required this.author, required
    this.totalPages, required this.coverUrl, required this.desc, required
    this.rating, required this.numRatings, required this.publisher,
    required this.publishedDate});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        id: json.containsKey('id') ? json['id'] : Null,
        title: json['volumeInfo'].containsKey('title') ? json['volumeInfo']['title'] : "Unknown",
        author: json['volumeInfo'].containsKey('authors') ? json['volumeInfo']['authors'][0] : "Unknown",
        totalPages: json["volumeInfo"].containsKey('pageCount') ? json['volumeInfo']["pageCount"] : 0,
        coverUrl: json['volumeInfo'].containsKey("imageLinks") ? json['volumeInfo']['imageLinks']['thumbnail'] : notFoundImage,
        desc: json.containsKey('description') ? json['description'] : "No Description",
        rating: json.containsKey('averageRating') ? json["averageRating"] : 0,
        numRatings: json.containsKey('ratingsCount') ? json['ratingsCount'] : 0,
        publisher: json.containsKey('publisher') ? json['publisher'] : "Not Found",
        publishedDate: json.containsKey('publishedDate') ? json['publishedDate'] : "Not Found"
    );
  }

}