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

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.totalPages,
    required this.coverUrl,
    required this.desc,
    required this.rating,
    required this.numRatings,
    required this.publisher,
    required this.publishedDate
  });

  factory Book.fromJson(Map<String, dynamic> json) {

    return Book(
        id: json.containsKey('id') ? json['id'] : "Not Found",
        title: json['volumeInfo'].containsKey('title') ? json['volumeInfo']['title'] : "Unknown",
        author: json['volumeInfo'].containsKey('authors') ? json['volumeInfo']['authors'][0] : "Unknown",
        totalPages: json['volumeInfo'].containsKey('pageCount') ? json['volumeInfo']["pageCount"] : 0,
        coverUrl: json['volumeInfo'].containsKey("imageLinks") ? json['volumeInfo']['imageLinks']['thumbnail'] : notFoundImage,
        desc: json['volumeInfo'].containsKey('description') ? json['volumeInfo']['description'] : "No Description",
        rating: json['volumeInfo'].containsKey('averageRating') ? json['volumeInfo']['averageRating'].toDouble() : 0.0,
        numRatings: json['volumeInfo'].containsKey('ratingsCount') ? json['volumeInfo']['ratingsCount'] : 0,
        publisher: json['volumeInfo'].containsKey('publisher') ? json['volumeInfo']['publisher'] : "Not Found",
        publishedDate: json['volumeInfo'].containsKey('publishedDate') ? json['volumeInfo']['publishedDate'] : "Not Found"
    );
  }


}