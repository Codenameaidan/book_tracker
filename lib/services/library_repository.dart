import '../models/book.dart';

//LibraryRepository is a Singleton
class LibraryRepository {

  static final LibraryRepository _instance = LibraryRepository._internal();

  // pass the instantiation to the _instance object
  factory LibraryRepository() => _instance;

  //Data
  List<Book> _completedReading = List<Book>.empty(growable: true);
  List<Book> _currentlyReading = List<Book>.empty(growable: true);
  List<Book> _toBeRead         = List<Book>.empty(growable: true);

  //initialize variables in here
  LibraryRepository._internal() {
    //Load from file?

  }


  //Getters
  List<Book> get completedReading => _completedReading;
  Book getCompletedBook(int id){
    for(int i = 0; i< _completedReading.length; i++){
      if(_completedReading[i].id == id){
        return _completedReading[i];
      }
    }
    throw Exception('ID not found.');
  }

  List<Book> get currentlyReading => _currentlyReading;
  List<Book> get toBeRead => _toBeRead;


  //Setters
  void setCompletedBook(Book b, int id){
    for(int i = 0; i< _completedReading.length; i++){
      if(_completedReading[i].id == id){
        _completedReading[i] = b;
        return;
      }
    }
    throw Exception('ID not found.');
  }



  Book getCurrentBook(String title){
    for(int i = 0; i< _completedReading.length; i++){
      if(_completedReading[i].title == title){
        return _completedReading[i];
      }
    }
    throw Exception('ID not found.');
  }


  void addCompletedBook(Book b){
    b.library = Library.completed;
    _completedReading.add(b);
  }
  void addCurrentBook(Book b){
    b.library = Library.reading;
    _currentlyReading.add(b);
  }
  void addToBeReadBook(Book b){
    b.library = Library.toBeRead;
    _toBeRead.add(b);
  }

  void removeCompletedBook(Book b){
    for(int i = 0; i< _completedReading.length; i++){
      if(_completedReading[i].id == b.id){
        _completedReading.removeAt(i);
      }
    }
  }
  void removeCurrentBook(Book b){
    for(int i = 0; i< _currentlyReading.length; i++){
      if(_currentlyReading[i].id == b.id){
        _currentlyReading.removeAt(i);
      }
    }
  }
  void removeToBeReadBook(Book b){
    for(int i = 0; i< _toBeRead.length; i++){
      if(_toBeRead[i].id == b.id){
        _toBeRead.removeAt(i);
      }
    }
  }

  void moveBookToCompleted(Book b){
    removeCurrentBook(b);
    removeToBeReadBook(b);

    addCompletedBook(b);
  }

  void moveBookToCurrent(Book b){
    removeCompletedBook(b);
    removeToBeReadBook(b);

    addCurrentBook(b);
  }

  void moveBookToBeRead(Book b){
    removeCurrentBook(b);
    removeCompletedBook(b);
    
    addToBeReadBook(b);
  }

  //See if book already exists, by id.
  bool bookExistsInCurrent(Book b){
    for(int i = 0; i< _currentlyReading.length; i++){
      if(_currentlyReading[i].id == b.id){
        return true;
      }
    }
    return false;
  }

  bool bookExistsInCompleted(Book b){
    for(int i = 0; i< _completedReading.length; i++){
      if(_completedReading[i].id == b.id){
        return true;
      }
    }
    return false;
  }

  bool bookExistsInToBeRead(Book b){
    for(int i = 0; i< _toBeRead.length; i++){
      if(_toBeRead[i].id == b.id){
        return true;
      }
    }
    return false;
  }

  String getLibraryName(Library l){
    if(l == Library.completed){
      return "Have Read";
    }else if(l == Library.toBeRead){
      return "Want to Read";
    }else if(l == Library.reading){
      return "Currently Reading";
    }
    return "";
  }

}