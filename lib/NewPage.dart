import 'package:flutter/material.dart';

class Newpage extends StatelessWidget {
  String title;
  Newpage({required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text(title),),
          body: Text('data'),
    ));
  }
}
