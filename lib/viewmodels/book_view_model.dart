import '../models/book.dart';

class BookViewModel {

  final Book book;

  BookViewModel({required this.book});

  String get id {
    return this.book.id;
  }

  String get title {
    return this.book.title;
  }

  String get author {
    return this.book.author;
  }

  int get totalPages {
    return this.book.totalPages;
  }

    String get coverUrl {
    return this.book.coverUrl;
  }

}

