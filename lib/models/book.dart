import 'dart:convert';
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
  final int totalPages;
  final String coverUrl;
  final String desc;
  final double rating;
  final int numRatings;
  final String publisher;
  final String publishedDate;

  int currentPage;
  Map<int, List<String>> notes;
  Library library = Library.none;

//Get JSON representation of this object (for file I/O)
  Map toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'desc': desc,
        'totalPages': totalPages,
        'rating':rating,
        'numRatings':numRatings,
        'coverUrl': coverUrl,
        'publisher':publisher,
        'publishedDate':publishedDate,
        'note_keys': notes.keys.toList(),
        'note_values': notes.values.toList(),
        'currentPage':currentPage,
        'library': library.toString()
      };



//Create a book from a file JSON representation
  factory Book.fromJsonFile(Map<String, dynamic> json) {
    Book book = Book(
      
        id: json['id'] as String, 
        title:  json['title'] as String, 
        author: json['author'] as String, 
        totalPages: json['totalPages'] as int,
        coverUrl: json['coverUrl'] as String,
        desc:  json['desc'] as String,
        rating: json['rating'] as double,
        numRatings:  json['numRatings'] as int,
        publisher: json['publisher'] as String,
        publishedDate:  json['publishedDate'] as String,
        notes: {},//null;//json['notes'] as Map<int, List<String>>,
        currentPage:json['currentPage'] as int
      );

    //Special handling for enums
    if(json['library'] == "Library.reading"){
        book.library = Library.reading;
    }else if(json['library'] == "Library.completed"){
        book.library = Library.completed;
    }else if(json['library'] == "Library.toBeRead"){
        book.library = Library.toBeRead;
    }

    //Notes
    var pages = json['note_keys'].cast<int>() as List<int>;

    var values =
      json['note_values'].map<List<String>>((l) => List<String>.from(l)).toList();

    for(int x = 0; x < pages.length; x++){
      book.notes[pages[x]] = values.elementAt(x);
    }

    return book;
  }


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
    required this.publishedDate,
    required this.notes,
    required this.currentPage,
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
        publishedDate: json['volumeInfo'].containsKey('publishedDate') ? json['volumeInfo']['publishedDate'] : "Not Found",
        notes: {},
        currentPage: 0
    );
  }


}