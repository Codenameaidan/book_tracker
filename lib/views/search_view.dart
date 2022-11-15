import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/search_view_model.dart';

class SearchView extends StatelessWidget {
  final String data;

  SearchView(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
             Text(data),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text('Back...'),
            )
          ],
        ),
      ),
    );

  }
}