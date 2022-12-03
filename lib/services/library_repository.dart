


import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

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
  List<Book> get currentlyReading => _currentlyReading;
  List<Book> get toBeRead => _toBeRead;

//Public functions
  void addCompletedBook(Book b){
    b.library = Library.completed;
    _completedReading.add(b);

    save();
  }

  void addCurrentBook(Book b){
    b.library = Library.reading;
    _currentlyReading.add(b);

    save();
  }
  void addToBeReadBook(Book b){
    b.library = Library.toBeRead;
    _toBeRead.add(b);

    save();
  }

  void moveBookToCompleted(Book b){
    _removeCurrentBook(b);
    _removeToBeReadBook(b);

    addCompletedBook(b);
  }

  void moveBookToCurrent(Book b){
    _removeCompletedBook(b);
    _removeToBeReadBook(b);

    addCurrentBook(b);
  }

  void moveBookToBeRead(Book b){
    _removeCurrentBook(b);
    _removeCompletedBook(b);

    addToBeReadBook(b);
  }

  void removeCompletedBook(Book b){
    _removeCompletedBook(b);
    save();
  }

  void removeCurrentBook(Book b){
    _removeCurrentBook(b);
    save();
  }

  void removeToBeReadBook(Book b){
    _removeToBeReadBook(b);
    save();
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


  //Return display name of given library enum
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

  //Save as JSON to local file
  void save() async{
    var everything = List<Book>.empty(growable: true);
    everything.addAll(_completedReading);
    everything.addAll(_currentlyReading);
    everything.addAll(_toBeRead);

    String jsonBooks = jsonEncode(everything);

    final file = await _localFile;
    file.writeAsString(jsonBooks);
  }

  //Load from local file
  Future<bool> load() async{
    final file = await _localFile;

    bool exists = await file.exists();

    if(!exists)
      return false;

    var x = await file.readAsString();

    var json = jsonDecode(x);

    List<dynamic> everything = json.map((book) => Book.fromJsonFile(book)).toList();
    for(int x = 0;x<everything.length;x++){
      Book b = everything.elementAt(x);
      if(b.library == Library.completed){
        addCompletedBook(b);
      }else if(b.library == Library.reading){
        addCurrentBook(b);
      }else if(b.library == Library.toBeRead){
        addToBeReadBook(b);
      }
    }

    return true;
  }


//Internal functions
  void _removeCompletedBook(Book b){
    for(int i = 0; i< _completedReading.length; i++){
      if(_completedReading[i].id == b.id){
        _completedReading.removeAt(i);
      }
    }

  }
  void _removeCurrentBook(Book b){
    for(int i = 0; i< _currentlyReading.length; i++){
      if(_currentlyReading[i].id == b.id){
        _currentlyReading.removeAt(i);
      }
    }
  }
  void _removeToBeReadBook(Book b){
    for(int i = 0; i< _toBeRead.length; i++){
      if(_toBeRead[i].id == b.id){
        _toBeRead.removeAt(i);
      }
    }
  }



  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.json');
  }
}