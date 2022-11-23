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

  //See if book already exists, by title.
  bool bookExistsInCurrent(Book b){
    for(int i = 0; i< _currentlyReading.length; i++){
      if(_currentlyReading[i].title == b.title){
        return true;
      }
    }
    return false;
  }

}