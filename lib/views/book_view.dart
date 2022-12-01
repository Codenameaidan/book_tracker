import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_tracker/services/library_repository.dart';
import 'package:readmore/readmore.dart';
import '../constants.dart';
import '../viewmodels/book_view_model.dart';
import 'currently_reading_view.dart';


class BookView extends StatefulWidget {

  BookViewModel book;

  BookView(this.book);

  @override
  _BookViewState createState() => _BookViewState();
}

final myController = TextEditingController();
final pageController = PageController(initialPage: 0);
final noteTextContolller = TextEditingController();
final notePageNumberContolller = TextEditingController();

class _BookViewState extends State<BookView>{
  @override
  Widget build(BuildContext context) {
    BookViewModel book = widget.book;

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(icon: Icon(Icons.arrow_back_ios), onPressed:() => pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.fastLinearToSlowEaseIn)),
            IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed:() => pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.fastLinearToSlowEaseIn)),
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
                      style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SizedBox(
                    child: Text(
                      "${book.rating}/5.0   (${book.numRatings}) Reviews",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white
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
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
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
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white
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
                    style: const TextStyle(
                      color: Colors.white70,
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
                      items: const [
                        DropdownMenuItem(value: 1, child: Center(child: Text(
                          "Want to Read",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )))),
                        DropdownMenuItem(value: 2, child: Center(child: Text(
                          "Currently Reading",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )))),
                        DropdownMenuItem(value: 3, child: Center(child: Text(
                          "Have Read",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )))),
                      ],
                      underline: const SizedBox(),
                      hint: const Center(child: Text(
                        "Add to List",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ))),
                      isExpanded: true,
                      dropdownColor: charcoal,
                      focusColor: darkCharcoal,
                      iconEnabledColor: Colors.white,
                      onChanged: (event) {
                        switch (event) {
                          case 1:
                            if (!LibraryRepository().bookExistsInToBeRead(book.book)){
                              LibraryRepository().addToBeReadBook(book.book);
                              //TO DO NAVIGATE TO CORRECT LIBRARY

                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => const CurReadView(),
                              //   )
                              // );
                            }
                            break;
                          case 2:
                            if (!LibraryRepository().bookExistsInCurrent(book.book)){
                              LibraryRepository().addCurrentBook(book.book);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const CurReadView(),
                                )
                              );
                            }
                            break;
                          case 3:
                            if (!LibraryRepository().bookExistsInCompleted(book.book)){
                              LibraryRepository().addCompletedBook(book.book);
                              //TO DO NAVIGATE TO CORRECT LIBRARY

                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => const CurReadView(),
                              //   )
                              // );
                            }
                            break;
                        }
                      },

                    )
                  ),

                )
              ]
            ),
            ListView(
              children: [
                Padding (
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
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
                              const Text("Page:"),
                              TextFormField(
                                controller: notePageNumberContolller,
                                keyboardType: TextInputType.number,
                                onFieldSubmitted:(text) {
                                        if (noteTextContolller.text.isNotEmpty && text.isNotEmpty) {
                                          book.addNoteToPage(int.parse(text), noteTextContolller.text);
                                          noteTextContolller.clear();
                                          notePageNumberContolller.clear();
                                        }
                                      },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter page number';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: noteTextContolller,
                                onFieldSubmitted: (text) {
                                        if (text.isNotEmpty && notePageNumberContolller.text.isNotEmpty) {
                                          book.addNoteToPage(int.parse(notePageNumberContolller.text), text);
                                          noteTextContolller.clear();
                                          notePageNumberContolller.clear();
                                        }
                                      },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              Row (
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: ElevatedButton(
                                      onPressed:() {
                                        if (noteTextContolller.text.isNotEmpty && notePageNumberContolller.text.isNotEmpty) {
                                          book.addNoteToPage(int.parse(notePageNumberContolller.text), noteTextContolller.text);
                                          noteTextContolller.clear();
                                          notePageNumberContolller.clear();
                                        }
                                      },
                                      child: const Text('Submit'),
                                    )
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
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
                  ),
                ),
              ],
            )
          ],



        )
    );
  }
}