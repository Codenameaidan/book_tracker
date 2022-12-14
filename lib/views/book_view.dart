import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reading_tracker/services/library_repository.dart';
import 'package:readmore/readmore.dart';
import '../constants.dart';
import '../models/book.dart';
import '../services/settings_controller.dart';
import '../viewmodels/book_view_model.dart';
import 'currently_reading_view.dart';


class BookView extends StatefulWidget {

  BookViewModel book;

  BookView(this.book);

  @override
  _BookViewState createState() => _BookViewState();
}


class _BookViewState extends State<BookView>{
  @override
  Widget build(BuildContext context) {

    

    final myController = TextEditingController();
    final pageController = PageController(initialPage: 0);
    final noteTextController = TextEditingController();
    final notePageNumberController = TextEditingController();
    final pagesReadController = TextEditingController();

    BookViewModel book = widget.book;
    Library library = book.getLibrary();

    Widget pageCounter = Center(child:Text(
      "Pages Read: ${book.currentPage}",
      style: TextStyle(fontSize: 22, color: SettingsController.foreground),
    ));

    bool bookInLibrary = LibraryRepository().bookExistsAnywhere(book.book);
    Widget updatePageButton =
    Padding(padding: const EdgeInsets.all(10), child:
      ElevatedButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Center(child: Text("Update Pages Read")),
                content: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Pages Read:"),
                      TextFormField(
                        controller: pagesReadController,
                        keyboardType: TextInputType.number,
                        onFieldSubmitted:(text) {
                                var numPages = int.tryParse(text);
                                if (numPages != null) {
                                  book.currentPage = book.currentPage + numPages;
                                  pagesReadController.clear();
                                  Navigator.pop(context);
                                }
                              },
                        validator: (value) {
                          if (value == null || value.isEmpty || int.tryParse(value) != null) {
                            return 'Please enter page number';
                          }
                          return null;
                        },
                      ),

                      Row (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: ElevatedButton(
                              onPressed:() {
                                if (int.tryParse(pagesReadController.text) != null){
                                  var numPages = int.tryParse(pagesReadController.text);
                                  if (numPages != null) {
                                    book.currentPage = book.currentPage + numPages;
                                    
                                    pagesReadController.clear();
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                     
                                    Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => new BookView(new BookViewModel(book: book.book)),
                                    ),
                                    );
                                  }
                                }
                              },
                              child: const Text('Submit'),
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            )
                          ),
                        ]
                      )
                    ],
                  ),
                )
              )
            );
          },
          child: const Padding (
            padding: EdgeInsets.all(5),
            child: Text('Update Pages'),
          )
      )
    );

    Widget addNoteButton =
    Padding(padding: const EdgeInsets.all(10), child:
      ElevatedButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Center(child: Text("Add Note")),
                content: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(

                        controller: notePageNumberController,
                        decoration: const InputDecoration(
                        icon: Icon(Icons.bookmark_add),
                        hintText: 'Input numbers only',
                        labelText: 'Page Number ',
                         ),

                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                         ],
                        onFieldSubmitted:(text) {
                                if (notePageNumberController.text.isNotEmpty && text.isNotEmpty) {
                                  book.addNoteToPage(int.parse(text), notePageNumberController.text);
                                  notePageNumberController.clear();
                                  notePageNumberController.clear();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => BookView(book)),
                                  );
                                  pageController.jumpToPage(1);
                                }
                              },
                        validator: (value) {
                          if (value == null || value.isEmpty || int.tryParse(value) != null) {
                            return 'Please enter page number';
                          }
                          return null;
                        },
                      ),

                      Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null, //grow automatically
                              controller: noteTextController,
                              decoration: const InputDecoration(
                              icon: Icon(Icons.notes),
                              labelText: 'Notes ',
                              ),
                              onFieldSubmitted: (text) {
                                      if (text.isNotEmpty && noteTextController.text.isNotEmpty) {
                                        book.addNoteToPage(int.parse(noteTextController.text), text);
                                        noteTextController.clear();
                                        noteTextController.clear();
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => BookView(book)),
                                        );
                                        pageController.jumpToPage(1);
                                      }
                                    },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';

                                }
                                return null;
                              },
                            ),
                          ),
                      ),
                      Row (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: ElevatedButton(
                              onPressed:() {
                                if (noteTextController.text.isNotEmpty && notePageNumberController.text.isNotEmpty && int.tryParse(notePageNumberController.text) != null) {
                                  book.addNoteToPage(int.parse(notePageNumberController.text), noteTextController.text);
                                  noteTextController.clear();
                                  notePageNumberController.clear();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => BookView(book)),
                                  );
                                  pageController.nextPage(duration: const Duration(milliseconds: 50), curve: Curves.linear);
                                }
                              },
                              child: const Text('Submit'),
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            )
                          ),
                        ]
                      )
                    ],
                  ),
                )
              )
            );
          },
          child: const Padding (
            padding: EdgeInsets.all(5),
            child: Text('Add Note'),
          )
      )
    );
    var noteDisplayList = [pageCounter, updatePageButton, addNoteButton];

   


    return Scaffold(
      
        appBar: AppBar(
          actions: [
            if(bookInLibrary)...[
              IconButton(icon: Icon(Icons.arrow_back_ios), onPressed:() => pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.fastLinearToSlowEaseIn)),
            
              IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed:() => pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.fastLinearToSlowEaseIn))
              ],
          ],
          title: TextFormField(
            controller: myController,
            decoration: const InputDecoration(
              hintText: 'Search',
            ),
            onEditingComplete:() {
                Navigator.pushNamed(context, searchRoute, arguments: myController.text);
            },
          )
        ),
        body: PageView(
          controller: pageController,
          children: [
            ListView(
              children: [
                SizedBox(
                  height: 200,
                  child:
                    Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(book.coverUrl, fit: BoxFit.cover),
                        ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              color: Colors.grey.withOpacity(0.1),
                              alignment: Alignment.center,
                              child: Padding (
                                padding: const EdgeInsets.only(bottom: 10, top: 10),
                                child: ClipRRect (
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(book.coverUrl, fit: BoxFit.contain)
                                )
                              )
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
                  child: SizedBox(
                    child: Text(
                      book.title,
                      style: TextStyle(fontSize: 20, color: SettingsController.foreground, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SizedBox(
                    child: Text(
                      "${book.rating}/5.0   (${book.numRatings}) Reviews",
                      style: TextStyle(
                        fontSize: 12,
                        color: SettingsController.foreground
                      ),
                      textAlign: TextAlign.center,
                    )
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: SizedBox(
                    child: Text(
                      "By ${book.author}",
                      style: TextStyle(
                        fontSize: 18,
                        color: SettingsController.foreground,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Published by ${book.publisher}",
                    style: TextStyle(
                        fontSize: 12,
                        color:SettingsController.foreground,
                      ),
                    textAlign: TextAlign.center,
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: ReadMoreText(
                    "\t ${book.desc}",
                    trimLines: 4,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: ' Show less',
                    style: TextStyle(
                      color: SettingsController.foreground,
                      fontSize: 14,
                    ),
                    moreStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: ruby
                    )
                  )
                ),
               Padding(
                padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: ruby,
                  ),
                child: DropdownButton(
                  items: [

                     if(library != Library.toBeRead)...[
                     DropdownMenuItem(value: 1, child: Center(
                      child: Text(
                      "Want to Read",
                      style: TextStyle(
                        fontSize: 18,
                        color: SettingsController.foreground,
                        fontWeight: FontWeight.bold
                    ))))],

                    if(library != Library.reading)...[
                      DropdownMenuItem(value: 2, child: Center(child: Text(
                        "Currently Reading",
                        style: TextStyle(
                          fontSize: 18,
                          color: SettingsController.foreground,
                          fontWeight: FontWeight.bold
                      ))))
                    ],

                    if(library != Library.completed)...[
                    DropdownMenuItem(value: 3, child: Center(child: Text(
                      "Have Read",
                      style: TextStyle(
                        fontSize: 18,
                        color: SettingsController.foreground,
                        fontWeight: FontWeight.bold
                    ))))],
                  ],
                  underline: const SizedBox(),
                  hint: Center(child: Text(
                    library == Library.none ? "Add to List" : "Move from "+LibraryRepository().getLibraryName(library),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ))),
                  isExpanded: true,
                  dropdownColor: SettingsController.background1,
                  focusColor: SettingsController.background2,
                  iconEnabledColor: Colors.white,
                  onChanged: (event) {
                    switch (event) {
                      case 1:
                        if(library == Library.none){
                          LibraryRepository().addToBeReadBook(book.book);
                        }else{
                          LibraryRepository().moveBookToBeRead(book.book);
                        }

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CurReadView(),
                          )
                        );

                        break;
                      case 2:
                        if(library == Library.none){
                          LibraryRepository().addCurrentBook(book.book);
                        }else{
                          LibraryRepository().moveBookToCurrent(book.book);
                        }

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CurReadView(),
                          )
                        );

                        break;
                      case 3:
                        if(library == Library.none){
                          LibraryRepository().addCompletedBook(book.book);
                        }else{
                          LibraryRepository().moveBookToCompleted(book.book);
                        }

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CurReadView(),
                          )
                        );


                        break;
                    }
                  },
                )
                  ),

                )
              ]
            ),
              
            Column(
              
              children: [
              Expanded(child:ListView(
              children: 
              
                noteDisplayList
                
              )),
              Expanded(child:ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: book.notes.length,
              itemBuilder: (BuildContext context, int index) {
                int key = book.notes.keys.elementAt(index);
                //addNoteButton;
                return Column(
                  children:[ 
                     ListTile(
                      title: Text("Page : $key", style: TextStyle(fontSize: 22, color: SettingsController.foreground),),
                      subtitle: Text("${book.notes[key]}", style: TextStyle(fontSize: 15, color: SettingsController.foreground),),
                    ),
                    //addNoteButton
                  ]
                );
              }, separatorBuilder: (BuildContext context, int index) => const Divider(),
            ),
            )]),
            
           
          
              
            
            
            //noteDisplayList
            
          ], //children 
            
         

        )
    );
  }
}