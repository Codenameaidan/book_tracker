enum Library{
    none,
    completed,
    reading,
    toBeRead
}

class Book {

  final int id;

  final String title;
  final String author;
  int totalPages;

  int currentPage = 0;

  Library library = Library.none;

  int rating = 0;
  
  String notes = "";

 
  Book({required this.id, required this.title, required this.author, required this.totalPages});

  /*factory Book.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json["Title"],
        posterUrl: json["Poster"]
    );
  }*/

}