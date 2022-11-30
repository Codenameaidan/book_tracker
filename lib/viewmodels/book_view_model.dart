import 'package:reading_tracker/services/library_repository.dart';

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

  String get desc {
    return this.book.desc;
  }

  String get publisher {
    return this.book.publisher;
  }

  String get publishedDate {
    return this.book.publishedDate;
  }

  double get rating {
    return this.book.rating;
  }

  int get numRatings {
    return this.book.numRatings;
  }

  Library getLibrary(){
    if(LibraryRepository().bookExistsInCompleted(book)) {
      return Library.completed;
    }
    if(LibraryRepository().bookExistsInCurrent(book)) {
      return Library.reading;
    }
    if(LibraryRepository().bookExistsInToBeRead(book)) {
      return Library.toBeRead;
    }

    return Library.none;
  }

}
