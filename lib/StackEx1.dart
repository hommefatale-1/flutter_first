import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.search),
              Center(child: Text("커비의 모험")),
              Icon(
                Icons.account_tree_rounded,
                size: 50,
              )
            ],
          ),
          backgroundColor: Colors.purpleAccent,
        ),
        body: MyWidget(),
        bottomNavigationBar: BottomAppBar(),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10,
          child: Container(
            width: 500,
            height: 500,
            color: Colors.blue,
          ),
        ),
        Positioned(
          bottom: 10,
          child: Container(
            width: 400,
            height: 500,
            color: Colors.yellowAccent,
          ),
        ),
        Positioned(
         top: 250,
          right: 100,
          child: Container(
            width: 300,
            height: 500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
