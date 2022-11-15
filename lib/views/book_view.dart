import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BookView extends StatefulWidget {
  const BookView({Key? key}) : super(key: key);

  @override
  _BookViewState createState() => _BookViewState();
}

class _BookViewState extends State<BookView>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( //copied from main.dart to be consistent
            title: TextFormField(
                  decoration: const InputDecoration(
                  hintText: 'Search',
                  )
            )
        ),//appbar close
    );
  }
}