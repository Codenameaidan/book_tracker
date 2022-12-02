import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../viewmodels/book_view_model.dart';
import '../viewmodels/to_be_read_view_model.dart';
import 'book_view.dart';

class ToBeReadView extends StatefulWidget {
  const ToBeReadView({Key? key}) : super(key: key);

  @override
  _ToBeReadViewState createState() => _ToBeReadViewState();
}

class _ToBeReadViewState extends State<ToBeReadView>{

final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var currList = context
        .watch<ToBeReadViewModel>()
        .tobeList;

    return Scaffold(
        appBar: AppBar(
            title: TextFormField(
                  controller: myController,
                  decoration: const InputDecoration(
                  hintText: 'Search',
                  ),
                  onEditingComplete:() {
                      Navigator.pushNamed(context, searchRoute, arguments: myController.text);
                  },
            )
        ),//appbar close
        drawer: Drawer(
          backgroundColor: charcoal,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(child: ListTile(
                    title:const Text("Currently Reading"),
                    textColor: Colors.white,
                    tileColor: darkCharcoal,
                    onTap:() => Navigator.pushNamed(context, homeRoute)
                  )),
                  const Card(child: ListTile(
                    title:Text("Want to Read"),
                    textColor: Colors.white,
                    tileColor: darkCharcoal,
                  )),
                  Card(child: ListTile(
                    title:Text("Have Read"),
                    textColor: Colors.white,
                    tileColor: darkCharcoal,
                    onTap:() => Navigator.pushNamed(context, haveReadRoute)
                  )),
                  const Card(child: ListTile(
                    title:Text("Settings"),
                    textColor: Colors.white,
                    tileColor: darkCharcoal,
                  )),
                ],
              ),
            )
          ),
        ),
        body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //TODO: add tabs to other views??
            const SizedBox(
              height: 15,
            ),
            const Text("Want to Read", style: TextStyle(fontSize: 22, color: Colors.white)),
            Expanded(
              child: ListView.builder(
                  itemCount: currList.length,
                  itemBuilder: (_, index) {
                    final currentBook = currList[index];
                    return Card(
                      key: ValueKey(currentBook.title),
                      color: lightRuby,
                      elevation: 4,
                      child: ListTile(
                        title: Text(currentBook.title),
                        subtitle:
                        Text(currentBook.author),
                        //TODO: any other text visible immediately ??
                        //trash icon button to remove book from list
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_forever,
                            size: 30,
                          ),
                          onPressed: () {
                            context
                                .read<ToBeReadViewModel>()
                                .removeFromList(currentBook);
                            }
                        ),//icon button close
                        //once you click on the book takes you to book view
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => new BookView(new BookViewModel(book: currentBook)),
                            ),
                          );
                        },//ontap close
                      ),//ListTile close
                    );//card close
                  }),//item builder and listviewbuilder close
            ),//expanded close
          ],//children close
        ),//child column close
      ),//body padding close
    );//scaffold close
  }//widget close
}//class close