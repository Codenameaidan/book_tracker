import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/currently_reading_view_model.dart';

class CurReadView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _CurReadViewState createState() => _CurReadViewState();
}

class _CurReadViewstate extends State<CurReadView>{
  @override
  Widget build(BuildContext context) {
    var currList = context
        .watch<CurrReadViewModel>()
        .currList;

    return Scaffold(
        appBar: AppBar( //copied from main.dart to be consistent
            title: TextFormField(
                  decoration: const InputDecoration(
                  hintText: 'Search',
                  )
            )
        ),//appbar close
        body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //TODO: add tabs to other views?? 
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (_, index) {
                    final currentBook = books[index];
                    return Card(
                      key: ValueKey(currentBook.title),
                      color: Colors.amberAccent.shade100,
                      elevation: 4,
                      child: ListTile(
                        title: Text(currentBook.title),
                        subtitle:
                        Text(currentBook.author ?? 'No information'),
                        //TODO: any other text visible immediately ?? 
                        //trash icon button to remove book from list 
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete_forever,
                            size: 30,
                          ),
                          onPressed: () {
                            context
                                .read<CurrReadViewModel>()
                                .removeFromList(currentBook);
                            }
                        ),//icon button close
                        //TODO: view book button (will be able to remove or add book in that view as well)
                      ),//ListTile close
                    );//card close
                  }),//item builder and listviewbuilder close
            ),//expanded close
          ],//children close
        ),//child column close
      ),//body padding close
    )//scaffold close
  }//widget close
}//class close