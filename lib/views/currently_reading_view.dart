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
}