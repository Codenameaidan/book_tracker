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
  int totalPages;
  int currentPage = 0;
  Library library = Library.none;
  int rating = 0;
  String notes = "";
  String coverUrl = "";

  Book({required this.id, required this.title, required this.author, required this.totalPages, required this.coverUrl});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        id: "Test",//json['id_google'][0],
        title: json['title'],
        author: json['author_name'] != null ? json['author_name'][0] : "Unknown",
        totalPages: json["number_of_pages_median"] != null ? json["number_of_pages_median"] : 0,
        coverUrl: 'https://covers.openlibrary.org/b/id/${json['cover_i']}-M.jpg'
    );
  }

}