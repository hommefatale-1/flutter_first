import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:math';

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

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  var random = Random();
  late Color containerColor;

  @override
  void initState() {
    super.initState();
    containerColor = Colors.white;

  }
  void changeColor(){
    setState(() {
      containerColor = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        0.1,
      );
    });
  }

  Widget box(BuildContext context, String text) {
    var size = MediaQuery.of(context).size;
    print(size);
    double width = size.width;
    double height = size.height;
    double top = random.nextDouble() * (height - 300) + 100 ;
    double left = random.nextDouble() * (width - 200);
    return Positioned(
        top: top,
        left: left,
        child: TextButton(
            onPressed: () {
              changeColor();
            },
            child: Container(
              width: 50,
              height: 50,
              color: containerColor,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),

        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> boxes =  [];
    for(int i = 1; i <= 10; i++){
      boxes.add(box(context,'$i'));
    }
    return Stack(
      children:boxes,
    );
  }
}
